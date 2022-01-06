class Admin::TodaysCalendarDateComponent < ViewComponent::Base
  attr_reader :calendar_date

  def initialize(current_user:, calendar_date:)
    super()
    @current_user = current_user
    @calendar_date = calendar_date.decorate
  end

  def render_form?
    @current_user.role_caretaker?
  end
end
