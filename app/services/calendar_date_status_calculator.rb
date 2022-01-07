class CalendarDateStatusCalculator
  delegate :active?, :date,
           :caretaker_informed?, :caretaker_confirmed_light?, :caretaker_dismissed_light?,
           :request_window_open_at?, :request_window_ends_at, to: :@calendar_date

  def initialize(calendar_date)
    @calendar_date = calendar_date
  end

  def status
    @status ||= find_status
  end

  private

  # rubocop:disable Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity
  def find_status
    return :not_active_today if not_active_today?
    return :light_dismissed if light_dismissed?
    return :light_confirmed if light_confirmed?
    return :date_in_future if date_in_future?
    return :not_requested_until_deadline if not_requested_until_deadline?
    return :light_requested if light_requested?
    return :requesting_light if requesting_light?
    return :request_window_open_now if request_window_open_now?
  end
  # rubocop:enable Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity

  def date_in_future?
    date.to_time.asctime.in_time_zone('Europe/Zurich').future?
  end

  def not_active_today?
    !active?
  end

  def light_dismissed?
    caretaker_dismissed_light?
  end

  def light_confirmed?
    caretaker_confirmed_light?
  end

  def not_requested_until_deadline?
    request_window_closed? && light_requests.none?
  end

  def requesting_light?
    request_window_ends_at_past? && light_requests.any? && caretaker_not_informed?
  end

  def light_requested?
    request_window_ends_at_past? && light_requests.any? && caretaker_informed?
  end

  def request_window_open_now?
    active? && request_window_open_at?(Time.zone.now)
  end

  def request_window_ends_at_past?
    active? && request_window_ends_at.past?
  end

  def request_window_closed?
    !request_window_open_now?
  end

  def caretaker_not_informed?
    !caretaker_informed?
  end

  def light_requests
    @light_requests ||= @calendar_date.light_requests
  end
end
