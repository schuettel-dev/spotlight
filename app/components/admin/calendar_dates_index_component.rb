class Admin::CalendarDatesIndexComponent < ViewComponent::Base
  attr_reader :todays_calendar_date, :past_calendar_dates

  def initialize(todays_calendar_date:, past_calendar_dates:)
    super()
    @todays_calendar_date = todays_calendar_date
    @past_calendar_dates = past_calendar_dates
  end
end
