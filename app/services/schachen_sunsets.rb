class SchachenSunsets
  NORMALIZING_YEAR = 2000

  def self.on(date)
    new_date = Date.new(NORMALIZING_YEAR, date.month, date.day)
    sunset = DateTime.parse(Rails.configuration.schachen_sunsets[new_date.to_s.to_sym])
    Time.utc(date.year, sunset.month, sunset.day, sunset.hour, sunset.min, sunset.sec)
  end
end
