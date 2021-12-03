class RevokeRequestComponent < ViewComponent::Base
  attr_reader :calendar_date, :user_light_request

  def initialize(calendar_date:, user_light_request:)
    @calendar_date = calendar_date
    @user_light_request = user_light_request
  end

  def render?
    calendar_date.awaiting_light_requests? && user_light_request.persisted?
  end
end
