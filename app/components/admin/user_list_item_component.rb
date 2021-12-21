class Admin::UserListItemComponent < ViewComponent::Base
  include Turbo::FramesHelper
  include Turbo::StreamsHelper

  attr_reader :user

  with_collection_parameter :user

  def initialize(user:)
    @user = user
    super()
  end
end
