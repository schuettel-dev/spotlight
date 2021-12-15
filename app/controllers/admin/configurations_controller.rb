class Admin::ConfigurationsController < AdminController
  def show
    render Admin::ConfigurationsShowComponent.new
  end
end
