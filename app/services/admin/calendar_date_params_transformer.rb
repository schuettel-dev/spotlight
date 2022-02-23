class Admin::CalendarDateParamsTransformer
  VALID_DECISIONS = %i[confirm dismiss reset].freeze

  def initialize(params)
    @params = params
  end

  def attributes
    @attributes ||= build_attributes
  end

  private

  def calendar_date_params
    @params.require(:calendar_date).permit(:active, :decision, :request_window_ends_at)
  end

  def build_attributes
    calendar_date_params.to_h.without(:decision).merge(decision_params)
  end

  def decision
    @decision ||= VALID_DECISIONS.dup.delete(calendar_date_params[:decision]&.to_sym)
  end

  def decision_params
    return {} if decision.blank?

    {
      caretaker_confirmed_light_at: caretaker_confirmed_light_at_value,
      caretaker_dismissed_light_at: caretaker_dismissed_light_at_value
    }
  end

  def caretaker_confirmed_light_at_value
    Time.zone.now if decision == :confirm
  end

  def caretaker_dismissed_light_at_value
    Time.zone.now if decision == :dismiss
  end
end
