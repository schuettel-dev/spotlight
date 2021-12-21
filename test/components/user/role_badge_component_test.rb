require 'test_helper'

class User::RoleBadgeComponentTest < ViewComponent::TestCase
  test 'render, role admin' do
    render_inline new_component(user_role: :admin)
    assert_selector '.text-amber-300', text: 'Admin'
  end

  test 'render, caretaker' do
    render_inline new_component(user_role: :caretaker)
    assert_selector '.text-fuchsia-300', text: 'Caretaker'
  end

  test 'render, superadmin' do
    render_inline new_component(user_role: :superadmin)
    assert_selector '.text-lime-300', text: 'Superadmin'
  end

  test 'not render, invalid role' do
    component = new_component(user_role: :user)
    assert_not component.render?
  end
end
