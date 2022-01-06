class Admin::CalendarDatesController < AdminController
  def index
    respond_to do |format|
      format.html do
        render Admin::CalendarDatesIndexComponent.new(
          todays_calendar_date: CalendarDate.for_today,
          past_calendar_dates: CalendarDate.with_light_requests.ordered_antichronologically
        )
      end
    end
  end

  def update
    # todo
  end
end
