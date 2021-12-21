class Admin::UserListItemComponent < ViewComponent::Base
  attr_reader :user

  with_collection_parameter :user

  def initialize(user:)
    @user = user
    super()
  end
end
