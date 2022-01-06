class CalendarDateDecisionService
  def initialize(calendar_date, decision)
    @calendar_date = calendar_date
    @decision = decision.to_sym
  end

  def call
    if @decision == :confirm
      @calendar_date.caretaker_confirmed_light!
    elsif @decision == :dismiss
      @calendar_date.caretaker_dismissed_light!
    elsif @decision == :reset
      @calendar_date.reset_caretaker_decision!
    end
  end
end
