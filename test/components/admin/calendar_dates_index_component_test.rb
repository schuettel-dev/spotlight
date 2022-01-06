require 'test_helper'

class Admin::CalendarDatesIndexComponentTest < ViewComponent::TestCase
  test '#render' do
    todays_calendar_date = calendar_dates(:thursday)
    past_calendar_dates = calendar_dates(:wednesday, :tuesday)

    render_inline(new_component(todays_calendar_date: todays_calendar_date, past_calendar_dates: past_calendar_dates))
    assert_selector 'h3', text: 'Today'
    assert_selector 'h3', text: 'Past'
  end
end
