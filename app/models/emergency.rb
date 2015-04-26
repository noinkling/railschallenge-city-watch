class Emergency < ActiveRecord::Base
  has_many :responders

  validates :code,
            presence: true,
            uniqueness: { case_sensitive: false }
  validates :fire_severity, :police_severity, :medical_severity,
            presence: true,
            numericality: { greater_than_or_equal_to: 0 }

  scope :full_responses, -> { where(full_response: true) }

  def update_dispatch
    # By default just removes the associations, not the records:
    responders.delete_all if resolved_at.present?
  end

  def dispatch_responders
    capacity_sufficient = true
    each_responder_type do |klass, severity|
      next if severity.zero?
      responders_to_dispatch = best_responders(klass, severity)
      responders_to_dispatch[:collection].each { |responder| responders << responder }
      capacity_sufficient = false unless responders_to_dispatch[:sufficient]
    end
    update(full_response: capacity_sufficient)
  end

  def self.full_response_score
    [full_responses.length, count]
  end

  private

  def each_responder_type
    Responder.subclasses.each do |klass|
      severity = send("#{klass.name.downcase}_severity")
      yield klass, severity
    end
  end

  def best_responders(klass, severity)
    best_matches = { collection: [], sufficient: false }
    single_match = single_responder_match(klass, severity)
    if single_match
      best_matches[:collection] << single_match
      best_matches[:sufficient] = true
    else
      dispatchable_responders_for(klass).each do |responder|
        best_matches[:collection] << responder
        if best_matches[:collection].map(&:capacity).reduce(:+) >= severity
          best_matches[:sufficient] = true
          break
        end
      end
    end
    best_matches
  end

  def single_responder_match(klass, severity)
    dispatchable_responders_for(klass).where('capacity >= ?', severity).last
  end

  def dispatchable_responders_for(klass)
    klass.available.on_duty.order(capacity: :desc)
  end
end
