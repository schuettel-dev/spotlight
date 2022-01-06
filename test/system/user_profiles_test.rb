require 'application_system_test_case'

class UserProfilesTest < ApplicationSystemTestCase
  test 'user changes profile' do
    sign_in_as(:bart)

    click_on 'Profile'

    assert_link 'Back', href: '/'

    assert_mobile ''
    assert_language 'English'

    fill_in 'Mobile', with: '0079112233'
    select 'German', from: 'Language'

    click_on 'Update profile'

    assert_mobile '0079112233'
    assert_language 'German'
  end

  private

  def assert_mobile(value)
    assert_equal value, find_field('Mobile').value.to_s
  end

  def assert_language(value)
    assert_select 'Language', selected: value
  end
end
