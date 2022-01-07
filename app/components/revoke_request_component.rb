class RevokeRequestComponent < ViewComponent::Base
  attr_reader :calendar_date, :user_light_request

  def initialize(calendar_date:, user_light_request:)
    @calendar_date = calendar_date
    @user_light_request = user_light_request
  end

  def render?
    calendar_date.request_window_open_now? && user_light_request.persisted?
  end
end
