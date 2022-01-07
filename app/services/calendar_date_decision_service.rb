class CalendarDateDecisionService
  def initialize(calendar_date, decision)
    @calendar_date = calendar_date
    @decision = decision.to_sym
  end

  def call
    case @decision
    when :confirm
      @calendar_date.caretaker_confirmed_light!
    when :dismiss
      @calendar_date.caretaker_dismissed_light!
    when :reset
      @calendar_date.reset_caretaker_decision!
    end
  end
end
