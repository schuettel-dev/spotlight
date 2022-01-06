require 'application_system_test_case'

class Admin::CalendarDateDecisionTest < ApplicationSystemTestCase
  test 'caretaker confirms' do
    travel_to '2001-01-04 12:00:00' do
      sign_in_as :willie
      navigate_to_admin_light_requests

      within '.calendar-date--today' do
        assert_text '6 light requests'
        click_button 'Confirm'
      end

      within '.calendar-date--today' do
        assert_text 'Light confirmed'
        assert_button 'Revoke decision'
      end
    end
  end

  test 'caretaker dismisses' do
    travel_to '2001-01-04 12:00:00' do
      sign_in_as :willie
      navigate_to_admin_light_requests

      within '.calendar-date--today' do
        assert_text '6 light requests'
        click_button 'Dismiss'
      end

      within '.calendar-date--today' do
        assert_text 'Light requests have been dismissed'
        assert_button 'Revoke decision'
      end
    end
  end

  test 'caretaker revokes decision' do
    travel_to '2001-01-04 12:00:00' do
      calendar_dates(:thursday).caretaker_confirmed_light!

      sign_in_as :willie
      navigate_to_admin_light_requests

      within '.calendar-date--today' do
        assert_text '6 light requests'
        click_button 'Revoke decision'
      end

      within '.calendar-date--today' do
        assert_text 'Collecting requests'
      end
    end
  end

  private

  def navigate_to_admin_light_requests
    navigate_to 'Admin'
    click_on 'Light requests'
  end
end
