class RequestFlowSectionComponent < ViewComponent::Base
  attr_reader :calendar_date

  def initialize(calendar_date:)
    @calendar_date = calendar_date
  end

  def render?
    calendar_date.request_window.active? && !calendar_date.not_requested_until_deadline?
  end
end
