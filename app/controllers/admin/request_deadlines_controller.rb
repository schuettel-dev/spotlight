class Admin::RequestDeadlinesController < AdminController
  def update
    request_deadline = RequestDeadline.find(params[:id])
    request_deadline.set_time(request_deadline_params.delete(:time))

    request_deadline.update(request_deadline_params)

    redirect_to admin_configuration_path
  end

  private

  def request_deadline_params
    params.require(:request_deadline).permit(:active, :time)
  end
end
