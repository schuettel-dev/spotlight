class Admin::CalendarDateActivationFormComponent < ViewComponent::Base
  attr_reader :calendar_date

  def initialize(calendar_date:)
    @calendar_date = calendar_date
    super()
  end

  def render?
    calendar_date.light_requests.none?
  end
end
