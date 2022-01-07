class Admin::WeekdayTemplatesController < AdminController
  def index
    respond_to do |format|
      format.html do
        render Admin::WeekdayTemplatesIndexComponent.new(weekday_templates: WeekdayTemplate.ordered)
      end
    end
  end

  def update
    weekday_template = WeekdayTemplate.find(params[:id])
    weekday_template.set_time(weekday_template_params.delete(:time)) if weekday_template_params.key?(:time)

    weekday_template.update(weekday_template_params)

    redirect_to admin_weekday_templates_path
  end

  private

  def weekday_template_params
    params.require(:weekday_template).permit(:active, :time)
  end
end
