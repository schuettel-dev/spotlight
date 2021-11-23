class Admin::ConfigurationsController < AdminController
  def show
    request_deadlines = RequestDeadline.ordered.rotate
    render Admin::ConfigurationsShowComponent.new(request_deadlines: request_deadlines)
  end
end
