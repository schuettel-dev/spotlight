class Admin::ConfigurationsController < AdminController
  def show
    request_deadlines = RequestDeadline.ordered
    render Admin::ConfigurationsShowComponent.new(request_deadlines: request_deadlines)
  end
end
