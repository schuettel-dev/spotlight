class TodayComponent < ViewComponent::Base
  attr_reader :calendar_date, :user_light_request

  def initialize(calendar_date:, user_light_request:)
    @calendar_date = calendar_date
    @user_light_request = user_light_request
  end

  def display_date
    calendar_date.date.to_s(:long)
  end
end
