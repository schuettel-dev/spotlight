class Admin::PastCalendarDatesComponent < ViewComponent::Base
  attr_reader :calendar_dates

  def initialize(calendar_dates:)
    @calendar_dates = calendar_dates
  end
end
