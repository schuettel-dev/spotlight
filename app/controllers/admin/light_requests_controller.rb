class Admin::LightRequestsController < AdminController
  def index
    respond_to do |format|
      format.html do
        render Admin::LightRequestsIndexComponent.new(
          calendar_dates: CalendarDate.with_light_requests.ordered_antichronologically
        )
      end
    end
  end

  def update
    # todo
  end
end
