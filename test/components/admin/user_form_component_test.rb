require 'test_helper'

class Admin::UserFormComponentTest < ViewComponent::TestCase
  test 'render, unverified' do
    render_inline new_component(user: users(:milhouse))
    assert_button 'Block'
    assert_no_button 'Unverify'
    assert_button 'Verify'
    assert_no_button 'Update role'
  end

  test 'render, blocked' do
    render_inline new_component(user: users(:kearney))
    assert_no_button 'Block'
    assert_button 'Unverify'
    assert_button 'Verify'
    assert_no_button 'Update role'
  end

  test 'render, verified / user' do
    render_inline new_component(user: users(:bart))
    assert_button 'Block'
    assert_button 'Unverify'
    assert_no_button 'Verify'
    assert_button 'Update role'
  end

  test 'render, verified / admin' do
    render_inline new_component(user: users(:marge))
    assert_no_button 'Block'
    assert_no_button 'Unverify'
    assert_no_button 'Verify'
    assert_button 'Update role'
  end

  test 'render, verified / caretaker' do
    render_inline new_component(user: users(:willie))
    assert_no_button 'Block'
    assert_no_button 'Unverify'
    assert_no_button 'Verify'
    assert_button 'Update role'
  end

  test 'not render, role superadmin' do
    component = new_component(user: users(:frink))
    assert_not component.render?
  end

  test '#role_selection' do
    component = new_component(user: User.new)
    assert_equal(
      [
        ['User', :user],
        ['Admin', :admin],
        ['Caretaker', :caretaker]
      ],
      component.role_selection
    )
  end
end
