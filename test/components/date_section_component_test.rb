require 'test_helper'

class DateSectionComponentTest < ViewComponent::TestCase
  test 'render' do
    render_inline new_component(calendar_date: calendar_dates(:tuesday))
    assert_selector 'time.calendar-date', text: 'January 02, 2001'
    assert_text 'Sunset at around 16:48', normalize_ws: true
  end
end
