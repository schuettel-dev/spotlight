class LightRequestsComponent < ViewComponent::Base
  attr_reader :calendar_date

  def initialize(calendar_date:)
    @calendar_date = calendar_date
  end

  def render?
    @calendar_date.request_window.active? && @calendar_date.request_window.time_window_start.past?
  end
end
