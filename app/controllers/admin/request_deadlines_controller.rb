class Admin::RequestDeadlinesController < AdminController
  def index
    respond_to do |format|
      format.html do
        render Admin::RequestDeadlinesIndexComponent.new(request_deadlines: RequestDeadline.ordered)
      end
    end
  end

  def update
    request_deadline = RequestDeadline.find(params[:id])
    request_deadline.set_time(request_deadline_params.delete(:time)) if request_deadline_params.key?(:time)

    request_deadline.update(request_deadline_params)

    redirect_to admin_request_deadlines_path
  end

  private

  def request_deadline_params
    params.require(:request_deadline).permit(:active, :time)
  end
end
