module CalendarService
  module_function

  TIME_ZONE = 'Europe/Zurich'.freeze

  def today_in_zurich
    now_in_zurich.to_date
  end

  def now_in_zurich
    Time.now.in_time_zone(TIME_ZONE)
  end

  def all_day_in_zurich(date)
    date.in_time_zone(TIME_ZONE).all_day
  end
end
