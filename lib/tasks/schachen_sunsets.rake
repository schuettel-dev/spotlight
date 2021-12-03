namespace :schachen_sunsets do
  desc 'Print Schachen sunsets as yaml'
  task as_yaml: :environment do
    require 'sun_times'

    LAT = 47.38934
    LON = 8.03969
    NORMALIZING_YEAR = 2000

    sun_times = SunTimes.new

    century_dates = (Date.new(2020, 1, 1)..Date.new(2029, 12, 13))

    schachen_sunset_times = century_dates.map do |century_date|
      sun_times.set(century_date, LAT, LON)
    end.group_by do |date|
      Date.new(NORMALIZING_YEAR, date.month, date.day).to_s
    end.map do |normalized_date, century_times|
      normalized_century_times = century_times.map do |time|
        Time.utc(NORMALIZING_YEAR, time.month, time.day, time.hour, time.min, time.sec)
      end

      most_regular_sunset_time = normalized_century_times.tally.sort_by { |_k, occurences| -occurences }.first.first

      [normalized_date, most_regular_sunset_time.to_s]
    end.to_h

    with_shared = { 'shared' => schachen_sunset_times }

    puts with_shared.to_yaml
  end
end
