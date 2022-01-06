class ProfilesController < ApplicationController
  def show
    respond_to do |format|
      format.html do
        render ProfileComponent.new(current_user: current_user)
      end
    end
  end

  def update
    if current_user.update(user_params)
      flash[:notice] = t('.success', locale: current_user.locale)
      redirect_to profile_path
    else
      render :show
    end
  end

  private

  def user_params
    params.require(:user).permit(:mobile, :locale)
  end
end
