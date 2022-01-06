require 'test_helper'

class ProfileComponentTest < ViewComponent::TestCase
  test '#render' do
    render_inline(new_component(current_user: users(:bart)))
    assert_link 'Back'
    assert_field 'Mobile'
    assert_select 'Language'
    assert_button 'Update profile'
  end

  test '#available_locales_options' do
    component = new_component(current_user: users(:bart))
    assert_equal(
      [
        ['English', :en],
        ['German', :de]
      ], component.available_locales_options
    )
  end

  test '#available_locales_options, ordered' do
    I18n.with_locale(:de) do
      component = new_component(current_user: users(:bart))
      assert_equal(
        [
          ['Deutsch', :de],
          ['Englisch', :en]
        ], component.available_locales_options
      )
    end
  end
end
