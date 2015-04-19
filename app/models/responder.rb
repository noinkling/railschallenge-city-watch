class Responder < ActiveRecord::Base
  validates :type, :name, :capacity,
    presence: true
  validates :name,
    uniqueness: { case_sensitive: false }
  validates :capacity,
    inclusion: { in: 1..5 }

  scope :available, -> { where(emergency: nil) }
  scope :on_duty, -> { where(on_duty: true) }

  def emergency_code
    nil
  end

  def self.capacities
    {
      capacity: {
        Fire: Fire.capacity,
        Police: Police.capacity,
        Medical: Medical.capacity
      }
    }
  end

  def self.capacity
    [
      all.sum(:capacity),
      all.sum(:capacity), #temp
      on_duty.sum(:capacity),
      on_duty.sum(:capacity) #temp
    ]
  end
end
