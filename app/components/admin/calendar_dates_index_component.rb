class Admin::CalendarDatesIndexComponent < ViewComponent::Base
  attr_reader :todays_calendar_date, :past_calendar_dates

  def initialize(todays_calendar_date:, past_calendar_dates:)
    @todays_calendar_date = todays_calendar_date
    @past_calendar_dates = past_calendar_dates
  end

  # def todays_calendar_date_component
  #   @todays_calendar_date_component ||= Admin::TodaysCalendarDateComponent.new(calendar_date: todays_calendar_date)
  # end

  # def past_calendar_dates_component
  #   @past_calendar_dates_component ||= Admin::PastCalendarDatesComponent.new(calendar_dates: past_calendar_dates)
  # end
end
