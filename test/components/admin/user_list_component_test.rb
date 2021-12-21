require 'test_helper'

class Admin::UserListComponentTest < ViewComponent::TestCase
  test 'render' do
    render_inline new_component(users: User.all)
    assert_selector '#admin_user_list'
    assert_text '13 users'
    assert_selector 'ul'
    assert_selector 'ul li', count: 13
  end
end
