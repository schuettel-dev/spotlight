class LightRequestsController < ApplicationController
  def create
    current_user.request_light_for_today
    redirect_to root_path
  end

  def destroy
    current_user.light_requests.find_by(id: params[:id])&.destroy
    redirect_to root_path
  end
end
