module CalendarService
  module_function

  TIME_ZONE = 'Europe/Zurich'.freeze

  def today_in_time_zone
    Time.zone.now.in_time_zone(TIME_ZONE).to_date
  end
end
