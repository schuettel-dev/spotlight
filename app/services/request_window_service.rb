class RequestWindowService
  delegate :active?, to: :weekday_template

  def initialize(calendar_date)
    @calendar_date = calendar_date
  end

  def open?
    active? && in_time_window?(Time.zone.now)
  end

  def in_time_window?(time)
    time_window.cover?(time)
  end

  def time_window
    @time_window ||= (calculate_time_window_start..calculate_time_window_end)
  end

  def time_window_start
    time_window.first
  end

  def time_window_end
    time_window.last
  end

  private

  def calculate_time_window_start
    @calendar_date.date.asctime.in_time_zone('Europe/Zurich').at_beginning_of_day
  end

  def calculate_time_window_end
    @calendar_date.date.to_datetime
                  .change(weekday_template_time_params)
                  .asctime
                  .in_time_zone('Europe/Zurich')
  end

  def weekday_template
    @weekday_template ||= WeekdayTemplate.for_date(@calendar_date.date)
  end

  def weekday_template_time_params
    {
      hour: weekday_template.time.hour,
      min: weekday_template.time.min
    }
  end
end
