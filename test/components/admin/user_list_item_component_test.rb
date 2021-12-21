require 'test_helper'

class Admin::UserListItemComponentTest < ViewComponent::TestCase
  test 'render' do
    render_inline new_component(user: users(:bart))
    assert_selector 'li'
    assert_text 'bart'
    assert_button 'Unverify'
  end
end
