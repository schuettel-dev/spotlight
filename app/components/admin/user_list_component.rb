class Admin::UserListComponent < ViewComponent::Base
  attr_reader :users

  def initialize(users:)
    @users = users
    super()
  end
end
