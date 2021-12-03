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

  def deadline
    @deadline ||= calculate_deadline
  end

  def in_time_window?(time)
    time_window.cover?(time)
  end

  def time_window
    (beginning_of_day..deadline)
  end

  private

  def beginning_of_day
    @calendar_date.date.asctime.in_time_zone('Europe/Zurich').at_beginning_of_day
  end

  def calculate_deadline
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
