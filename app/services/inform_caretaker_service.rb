class InformCaretakerService
  def initialize(calendar_date)
    @calendar_date = calendar_date
  end

  def call!
    inform_caretaker! if due?
  end

  private

  def inform_caretaker!
    # TODO: send messages
    @calendar_date.caretaker_informed!
  end

  def due?
    todays_weekday? && calendar_date_active? && request_time_window_end_past? && caretaker_not_informed?
  end

  def todays_weekday?
    @calendar_date.date.wday == CalendarService.today_in_zurich.wday
  end

  def calendar_date_active?
    @calendar_date.active?
  end

  def request_time_window_end_past?
    @calendar_date.request_window_ends_at.past?
  end

  def caretaker_not_informed?
    !@calendar_date.caretaker_informed?
  end
end
