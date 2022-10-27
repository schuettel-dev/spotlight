class TodaysController < ApplicationController
  skip_before_action :authenticate_user!

  def show
    respond_to do |format|
      format.html do
        render TodayComponent.new(calendar_date: find_calendar_date,
                                  user_light_request: find_user_light_request)
      end
    end
  end

  def status
    respond_to do |format|
      format.html do
        render StatusSectionComponent.new(calendar_date: find_calendar_date)
      end
    end
  end

  private

  def find_calendar_date
    CalendarDate.with_light_requests.find_or_create_for_today
  end

  def find_user_light_request
    current_user&.light_request_for_today || LightRequest.new
  end
end
