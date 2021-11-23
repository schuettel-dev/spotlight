class AdminController < ApplicationController
  before_action :authenticate_admin

  private

  def authenticate_admin
    return if current_user.admin?

    redirect_to root_path, alert: t('shared.errors.access_denied_for_non_admins')
  end
end
