class FlightRecordForm < SimpleDelegator

  attr_accessor :flight_date, :flight_time, :departure_time_zone
  attr_reader :attrs, :bits

  def self.build(params)
    new(params).build
  end

  def initialize(params=nil)
    if params
      @bits = params.slice!('confirmation', 'first_name', 'last_name', 'email')
      @attrs = params
    else
      super FlightRecord.new
    end
  end

  def flight_record
    __getobj__
  end

  def self.model_name
    FlightRecord.model_name
  end

  def attributes=(attrs)
    attrs.each do |attr, value|
      setter = "#{attr}="
      send(setter, value) if respond_to? setter
    end
  end

  def build
    attrs['depart_at'] = depart_at
    FlightRecord.new attrs
  end

  private

  def depart_at
    DateTime.strptime bits.values.join(' '), "%m/%d/%Y %H:%M %z"
  end
end
