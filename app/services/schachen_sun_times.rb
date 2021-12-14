require 'sun_times'

class SchachenSunTimes
  LAT = 47.38934
  LON = 8.03969
  NORMALIZING_YEAR = 2000

  delegate :to_yaml, to: collect_schachen_sunset_times

  private

  def sun_times
    @sun_times ||= SunTimes.new
  end

  def century_dates
    (Date.new(2020, 1, 1)..Date.new(2029, 12, 13))
  end

  def century_dates_sunset_times
    century_dates.map do |century_date|
      sun_times.set(century_date, LAT, LON)
    end
  end

  def sunset_times_grouped_by_date_in_year
    century_dates_sunset_times.group_by do |date|
      Date.new(NORMALIZING_YEAR, date.month, date.day).to_s
    end
  end

  def most_common_sunset_times_by_date_in_year
    sunset_times_grouped_by_date_in_year.map do |normalized_date, century_times|
      normalized_century_times = century_times.map do |time|
        Time.utc(NORMALIZING_YEAR, time.month, time.day, time.hour, time.min, time.sec)
      end

      most_regular_sunset_time = normalized_century_times.tally.max_by { |_k, occurences| occurences }.first

      [normalized_date, most_regular_sunset_time.to_s]
    end.to_h
  end

  def collect_schachen_sunset_times
    schachen_sunset_times = most_common_sunset_times_by_date_in_year

    { 'shared' => schachen_sunset_times }
  end
end
