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
    todays_weekday? && calendar_date_active? && deadline_past? && caretaker_not_informed?
  end

  def todays_weekday?
    @calendar_date.date.wday == CalendarService.today_in_time_zone.wday
  end

  def calendar_date_active?
    @calendar_date.request_window.active?
  end

  def deadline_past?
    @calendar_date.request_window.deadline.past?
  end

  def caretaker_not_informed?
    !@calendar_date.caretaker_informed?
  end
end
