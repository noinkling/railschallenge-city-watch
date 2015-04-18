class Responder < ActiveRecord::Base
  validates :type, :name, :capacity, presence: true
  validates :name,                   uniqueness: { case_sensitive: false }
  validates :capacity,               inclusion: { in: 1..5 }

  def to_slug
    name.parametize
  end

  def emergency_code
    nil
  end
end
