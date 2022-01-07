class LightRequestsComponent < ViewComponent::Base
  attr_reader :calendar_date

  def initialize(calendar_date:)
    @calendar_date = calendar_date
  end

  def render?
    @calendar_date.active? && @calendar_date.request_window_starts_at.past?
  end
end
