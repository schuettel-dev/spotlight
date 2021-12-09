class CalendarDateStatusCalculator

  delegate :caretaker_informed?, :caretaker_confirmed_light?, :caretaker_dismissed_light?, to: :@calendar_date

  def initialize(calendar_date)
    @calendar_date = calendar_date
  end

  def status
    @status ||= find_status
  end

  private

  def find_status
    return :not_active_today if not_active_today?
    return :light_dismissed if light_dismissed?
    return :light_confirmed if light_confirmed?
    return :not_requested_until_deadline if not_requested_until_deadline?
    return :light_requested if light_requested?
    return :requesting_light if requesting_light?
    return :awaiting_light_requests if awaiting_light_requests?
  end

  def not_active_today?
    !active?
  end

  def light_dismissed?
    request_window_closed? && caretaker_dismissed_light?
  end

  def light_confirmed?
    request_window_closed? && caretaker_confirmed_light?
  end

  def not_requested_until_deadline?
    request_window_closed? && light_requests.none?
  end

  def requesting_light?
    request_window_deadline_past? && light_requests.any? && caretaker_not_informed?
  end

  def light_requested?
    request_window_closed? && light_requests.any? && caretaker_informed?
  end

  def awaiting_light_requests?
    @calendar_date.request_window.open?
  end

  def active?
    @calendar_date.request_window.active?
  end

  def request_window_open?
    active? && @calendar_date.request_window.open?
  end

  def request_window_deadline_past?
    active? && @calendar_date.request_window.time_window_end.past?
  end

  def request_window_closed?
    !request_window_open?
  end

  # def caretaker_informed?
  #   @calendar_date.caretaker_informed_at.present?
  # end

  # def caretaker_confirmed_light?
  #   @calendar_date.caretaker_confirmed_light_at.present?
  # end

  # def caretaker_dismissed_light?
  #   @calendar_date.caretaker_dismissed_light_at.present?
  # end

  def caretaker_not_informed?
    !caretaker_informed?
  end

  def light_requests
    @light_requests ||= @calendar_date.light_requests
  end
end
