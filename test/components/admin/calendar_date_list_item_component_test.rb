require 'test_helper'

class Admin::CalendarDateListItemComponentTest < ViewComponent::TestCase
  test '#render' do
    travel_to '2001-01-04 12:00:00 +01:00' do
      render_inline(new_component(calendar_date: calendar_dates(:thursday)))
      assert_selector '.calendar-date--status', text: 'Collecting requests'
      assert_selector '.calendar-date--light-requests-with-count', text: '6 light requests'
    end
  end
end
