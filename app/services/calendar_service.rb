module CalendarService
  module_function

  TIME_ZONE = 'Europe/Zurich'.freeze

  def today_in_time_zone
    now_in_time_zone.to_date
  end

  def now_in_time_zone
    Time.now.in_time_zone(TIME_ZONE)
  end

  def all_day_in_time_zone(date)
    date.in_time_zone(TIME_ZONE).all_day
  end
end
