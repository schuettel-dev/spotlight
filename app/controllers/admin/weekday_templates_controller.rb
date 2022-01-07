class Admin::WeekdayTemplatesController < AdminController
  before_action :set_weekday_template, only: :update
  def index
    respond_to do |format|
      format.html do
        render Admin::WeekdayTemplatesIndexComponent.new(weekday_templates: WeekdayTemplate.ordered)
      end
    end
  end

  def update
    @weekday_template.set_request_window_ends_at(weekday_template_params.delete(:request_window_ends_at))
    @weekday_template.update(weekday_template_params)

    redirect_to admin_weekday_templates_path
  end

  private

  def weekday_template_params
    params.require(:weekday_template).permit(:active, :request_window_ends_at)
  end

  def set_weekday_template
    @weekday_template = WeekdayTemplate.find(params[:id])
  end
end
