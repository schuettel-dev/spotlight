require 'test_helper'

class Admin::TodaysCalendarDateComponentTest < ViewComponent::TestCase
  test '#render, caretaker' do
    travel_to '2001-01-04 12:00:00 UTC+1' do
      render_inline(new_component(current_user: users(:willie), calendar_date: calendar_dates(:thursday)))

      assert_text '6 light requests'
      assert_text 'Collecting requests'
      assert_text 'Deadline at 16:30'

      assert_button 'Confirm'
      assert_button 'Dismiss'
    end
  end

  test '#render, admin' do
    travel_to '2001-01-04 12:00:00 UTC+1' do
      render_inline(new_component(current_user: users(:marge), calendar_date: calendar_dates(:thursday)))

      assert_text '6 light requests'
      assert_text 'Collecting requests'
      assert_text 'Deadline at 16:30'

      assert_no_button 'Confirm'
    end
  end
end
