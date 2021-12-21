require 'test_helper'

class Admin::UsersIndexComponentTest < ViewComponent::TestCase
  test 'render' do
    render_inline new_component(users: User.all)
    assert_link 'Back', href: '/admin/configuration'
    assert_selector 'h2', text: 'Users'
    assert_selector 'ul'
  end
end
