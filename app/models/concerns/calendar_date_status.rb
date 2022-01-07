module CalendarDateStatus
  extend ActiveSupport::Concern

  def status
    @status ||= calculate_status
  end

  def reset_status
    @status = calculate_status
  end

  def decided?
    light_confirmed? || light_dismissed?
  end

  # combined status
  def no_light_confirmed?
    not_active_today? || not_requested_until_deadline? || light_dismissed?
  end

  # raw status
  def date_in_future?
    status == :date_in_future
  end

  def request_window_open_now?
    status == :request_window_open_now
  end

  def requesting_light?
    status == :requesting_light
  end

  def light_requested?
    status == :light_requested
  end

  def light_confirmed?
    status == :light_confirmed
  end

  def light_dismissed?
    status == :light_dismissed
  end

  def not_requested_until_deadline?
    status == :not_requested_until_deadline
  end

  def not_active_today?
    status == :not_active_today
  end

  private

  def calculate_status
    CalendarDateStatusCalculator.new(self).status
  end
end
