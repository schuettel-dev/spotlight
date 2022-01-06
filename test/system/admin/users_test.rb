require 'application_system_test_case'

class Admin::UsersTest < ApplicationSystemTestCase
  test 'admin changes user status, using browser' do
    using_browser do
      sign_in_as :marge
      navigate_to_admin_users

      within find_user_in_list('milhouse') do
        assert_no_status_badge
        open_form

        click_on 'Verify'
        assert_status_badge :verified

        click_on 'Block'
        assert_status_badge :blocked
      end
    end
  end

  test 'admin changes user role, using browser' do
    using_browser do
      sign_in_as :marge
      navigate_to_admin_users

      within find_user_in_list('bart') do
        assert_no_role_badge
        open_form

        change_role 'Admin'
        assert_role_badge 'Admin'

        change_role 'Caretaker'
        assert_role_badge 'Caretaker'
      end
    end
  end

  test 'forms stay opened after leaving and returning to page' do
    using_browser do
      sign_in_as :marge
      navigate_to_admin_users

      within find_user_in_list('bart') do
        assert_no_button 'Block'
        assert_no_button 'Unverify'

        open_form

        assert_button 'Block'
        assert_button 'Unverify'
      end

      click_on 'Back'
      click_on 'Users'

      within find_user_in_list('bart') do
        assert_button 'Block'
        assert_button 'Unverify'
      end
    end
  end

  private

  def navigate_to_admin_users
    navigate_to 'Admin'
    click_on 'Users'
  end

  def find_user_in_list(nickname)
    find('li', text: nickname)
  end

  def assert_no_status_badge
    assert_status_badge :verified, count: 0
    assert_status_badge :blocked, count: 0
  end

  def assert_no_role_badge
    assert_role_badge 'Admin', count: 0
    assert_role_badge 'Caretaker', count: 0
    assert_role_badge 'Superadmin', count: 0
  end

  def assert_status_badge(status, count: 1)
    badge_icon_css_class = User::StatusBadgeComponent::USER_STATUSES.dig(status, :icon)
    assert_selector(".user--status-badge .heroicon-#{badge_icon_css_class}", count: count)
  end

  def assert_role_badge(text, count: 1)
    assert_selector('.user--role-badge', text: text, count: count)
  end

  def open_form
    find('svg.heroicon-chevron-down').click
  end

  def change_role(role)
    select role, from: 'user_role'
    click_on 'Update role'
  end
end
