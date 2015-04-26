class Responder < ActiveRecord::Base
  belongs_to :emergency

  validates :type, :name, :capacity,
            presence: true
  validates :name,
            uniqueness: { case_sensitive: false }
  validates :capacity,
            inclusion: { in: 1..5 }

  scope :available, -> { where(emergency_id: nil) }
  scope :on_duty, -> { where(on_duty: true) }

  delegate :code, to: :emergency, prefix: true, allow_nil: true # .emergency_code

  def self.capacities_by_type
    capacities = { capacity: {} }
    Responder.subclasses.each do |klass|
      capacities[:capacity][:"#{klass.name}"] = klass.capacity
    end
    capacities
  end

  def self.capacity
    [
      all.sum(:capacity),
      available.sum(:capacity),
      on_duty.sum(:capacity),
      available.on_duty.sum(:capacity)
    ]
  end
end
