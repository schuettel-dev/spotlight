class RequestWindowService
  delegate :active?, to: :weekday_template

  def initialize(calendar_date)
    @calendar_date = calendar_date
  end

  def request_window_starts_at
    @request_window_starts_at ||= fetch_and_transform_from_weekday_template(:request_window_starts_at)
  end

  def request_window_ends_at
    @request_window_ends_at ||= fetch_and_transform_from_weekday_template(:request_window_ends_at)
  end

  private


  def fetch_and_transform_from_weekday_template(attribute)
    @calendar_date.date.to_datetime
                  .change(time_options_for(attribute))
                  .asctime
                  .in_time_zone('Europe/Zurich')
  end

  def time_options_for(attribute)
    {
      hour: weekday_template[attribute].hour,
      min: weekday_template[attribute].min
    }
  end

  def weekday_template
    @weekday_template ||= WeekdayTemplate.for_date(@calendar_date.date)
  end
end
