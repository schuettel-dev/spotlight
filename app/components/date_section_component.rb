class DateSectionComponent < ViewComponent::Base
  attr_reader :calendar_date

  def initialize(calendar_date:)
    @calendar_date = calendar_date
  end

  def display_date
    calendar_date.date.to_formatted_s(:long)
  end

  def sun_sets_at
    SchachenSunsets.on(calendar_date.date).in_time_zone('Europe/Zurich')
  end

  def display_sun_sets_at
    I18n.l(sun_sets_at, format: :day_time_only)
  end
end
