class TodaysController < ApplicationController
  skip_before_action :authenticate_user!

  def show
    render TodayComponent.new(calendar_date: find_calendar_date,
                              user_light_request: find_user_light_request)
  end

  private

  def find_calendar_date
    CalendarDate.with_light_requests.for_today
  end

  def find_user_light_request
    current_user&.light_request_for_today || LightRequest.new
  end
end
