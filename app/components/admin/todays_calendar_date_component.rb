class Admin::TodaysCalendarDateComponent < ViewComponent::Base
  attr_reader :calendar_date

  def initialize(calendar_date:)
    super()
    @calendar_date = calendar_date.decorate
  end
end
