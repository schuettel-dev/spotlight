class Admin::TodaysCalendarDateComponent < ViewComponent::Base
  attr_reader :current_user, :calendar_date

  def initialize(current_user:, calendar_date:)
    super()
    @current_user = current_user
    @calendar_date = calendar_date
  end

  private

  def status_color_css
    calendar_date.decorate.statuses_settings.dig(calendar_date.status, :css, :'text-primary')
  end
end
