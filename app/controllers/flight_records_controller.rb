class FlightRecordsController < ApplicationController
  use Rack::Auth::Basic, "Restricted Area" do |user, pass|
    user == 'andrew' and pass == 'rulez'
  end

  expose(:flight_record) { |record| RecordDecorator.new(record) }
  expose :flight_record_form, attributes: :flight_record_params, model: FlightRecordForm
  expose(:incomplete_flights) { FlightRecord.incomplete_flights(5) }
  expose(:complete_flights) { FlightRecord.complete_flights(5) }

  def create
    flight_record = FlightRecordForm.build flight_record_params

    if flight_record.save
      CheckinJob.schedule flight_record
      flash[:notice] = "#{flight_record.first_name}, you will be automatically checked-in for your flight."
      redirect_to new_flight_record_path
    else
      flash[:error] = "You left something blank -- or I messed something up and you should text me."
      render :new
    end
  end

  private

  def flight_record_params
    params.require(:flight_record).permit(:confirmation, :first_name, :last_name, :email, :boarding_number, :flight_date, :flight_time, :departure_time_zone)
  end
end
