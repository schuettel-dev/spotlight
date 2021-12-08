class RequestWindowService
  def initialize(calendar_date)
    @calendar_date = calendar_date
  end

  def open?
    active? && in_time_window?(Time.zone.now)
  end

  def active?
    request_deadline.active?
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
                       .change(request_deadline_time_params)
                       .asctime
                       .in_time_zone('Europe/Zurich')
  end

  def request_deadline
    @request_deadline ||= RequestDeadline.for_date(@calendar_date.date)
  end

  def request_deadline_time_params
    {
      hour: request_deadline.time.hour,
      min: request_deadline.time.min
    }
  end
end
