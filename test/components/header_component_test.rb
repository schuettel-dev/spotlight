require 'test_helper'

class HeaderComponentTest < ViewComponent::TestCase
  test '#render, not signed in' do
    render_inline(new_component(current_user: nil))
    assert_text 'SPOTLIGHT'

    assert_link 'Sign in'
    assert_no_link 'Home'
    assert_no_link 'Profile'
    assert_no_link 'Admin'
    assert_no_button 'Sign out'
  end

  test '#render, signed in, normal user' do
    render_inline(new_component(current_user: users(:bart)))
    assert_text 'SPOTLIGHT'

    assert_no_link 'Sign in'
    assert_link 'Home'
    assert_link 'Profile'
    assert_no_link 'Admin'
    assert_button 'Sign out'
  end

  test '#render, signed in, admin' do
    render_inline(new_component(current_user: users(:marge)))
    assert_text 'SPOTLIGHT'

    assert_no_link 'Sign in'
    assert_link 'Home'
    assert_link 'Profile'
    assert_link 'Admin'
    assert_button 'Sign out'
  end
end
