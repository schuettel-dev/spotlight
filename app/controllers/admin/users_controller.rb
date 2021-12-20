class Admin::UsersController < AdminController
  before_action :set_user, only: :update

  def index
    respond_to do |format|
      format.html do
        render Admin::UsersIndexComponent.new(users: User.with_light_requests.ordered_by_nickname)
      end
    end
  end

  def update
    if @user.update(user_params)
      flash[:notice] = t('.success')
    else
      flash[:alert] = t('.failure')
    end

    redirect_to admin_users_path
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:role, :status)
  end
end
