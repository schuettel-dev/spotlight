class Admin::UsersIndexComponent < ViewComponent::Base
  include Turbo::StreamsHelper

  attr_reader :users

  def initialize(users:)
    @users = users
    super()
  end
end
