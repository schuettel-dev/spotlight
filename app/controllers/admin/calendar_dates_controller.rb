class Admin::CalendarDatesController < AdminController
  before_action :set_calendar_date, only: :update

  def index
    respond_to do |format|
      format.html do
        render Admin::CalendarDatesIndexComponent.new(
          current_user: current_user,
          todays_calendar_date: CalendarDate.for_today,
          past_calendar_dates: CalendarDate.before_today_in_zurich
                                           .with_light_requests
                                           .ordered_antichronologically
        )
      end
    end
  end

  def update
    CalendarDateDecisionService.new(@calendar_date, calendar_date_params[:decision]).call

    redirect_to admin_calendar_dates_path
  end

  private

  def calendar_date_params
    params.require(:calendar_date).permit(:decision)
  end

  def set_calendar_date
    @calendar_date = CalendarDate.find(params[:id])
  end
end
