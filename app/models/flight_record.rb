class FlightRecord < ActiveRecord::Base
  validates_presence_of :confirmation, :first_name, :last_name, :email, :depart_at

  def checked_in!
    update_attribute :status, 'complete'
  end

  def add_boarding_number(num)
    update_attribute :boarding_number, num
  end

  def self.incomplete_flights(limit)
    FlightRecord.where(status: 'incomplete').limit(limit)
  end

  def self.complete_flights(limit)
    FlightRecord.where(status: 'complete').limit(limit)
  end
end
