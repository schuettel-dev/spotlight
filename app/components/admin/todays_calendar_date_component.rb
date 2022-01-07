class Admin::TodaysCalendarDateComponent < ViewComponent::Base
  attr_reader :current_user, :calendar_date

  def initialize(current_user:, calendar_date:)
    super()
    @current_user = current_user
    @calendar_date = calendar_date
  end
end
