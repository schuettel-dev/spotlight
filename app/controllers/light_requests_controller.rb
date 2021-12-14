class LightRequestsController < ApplicationController
  def create
    flash[:alert] = t('.error') unless current_user.request_light_for_today

    redirect_to root_path, status: :see_other
  end

  def destroy
    flash[:alert] = t('.error') unless current_user.light_requests.find_by(id: params[:id])&.destroy

    redirect_to root_path, status: :see_other
  end
end
