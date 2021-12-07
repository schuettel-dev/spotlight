class LightRequestsController < ApplicationController
  def create
    if !current_user.request_light_for_today
      flash[:alert] = t('.error')
    end

    redirect_to root_path, status: :see_other
  end

  def destroy
    if !current_user.light_requests.find_by(id: params[:id])&.destroy
      flash[:alert] = t('.error')
    end

    redirect_to root_path, status: :see_other
  end
end
