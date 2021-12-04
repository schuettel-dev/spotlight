class RequestButtonComponent < ViewComponent::Base
  attr_reader :calendar_date, :user_light_request

  def initialize(calendar_date:, user_light_request:)
    @calendar_date = calendar_date
    @user_light_request = user_light_request
  end

  def user_signed_in?
    user_light_request.user.present?
  end

  def render?
    calendar_date.awaiting_light_requests? && new_light_request?
  end

  def new_light_request?
    user_light_request.new_record?
  end
end
