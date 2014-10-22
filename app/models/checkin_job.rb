class CheckinJob
  @queue = :basic

  def self.perform(record_id)
    TravelAgent.checkin FlightRecord.find record_id
  end

  def self.schedule(record)
    checkin_time = record.depart_at - 1.day
    Resque.enqueue_at checkin_time, CheckinJob, record.id
  end
end
