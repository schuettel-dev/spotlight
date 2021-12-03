class LightRequestsIconsComponent < ViewComponent::Base
  attr_reader :light_requests

  def initialize(light_requests:)
    @light_requests = light_requests
  end

  def render?
    light_requests.count.positive?
  end
end
