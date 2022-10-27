class TodayComponent < ViewComponent::Base
  include Turbo::StreamsHelper
  include Turbo::FramesHelper

  attr_reader :calendar_date, :user_light_request

  def initialize(calendar_date:, user_light_request:)
    @calendar_date = calendar_date
    @user_light_request = user_light_request
  end
end
