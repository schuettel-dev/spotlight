class Admin::CalendarDatesIndexComponent < ViewComponent::Base
  attr_reader :current_user, :todays_calendar_date, :past_calendar_dates

  def initialize(current_user:, todays_calendar_date:, past_calendar_dates:)
    super()
    @current_user = current_user
    @todays_calendar_date = todays_calendar_date
    @past_calendar_dates = past_calendar_dates
  end
end
