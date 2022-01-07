require 'test_helper'

class StatusSectionComponentTest < ViewComponent::TestCase
  test 'render general' do
    render_inline(new_component(calendar_date: CalendarDate.for_today))
    assert_selector 'h2', text: 'Status'
  end

  test 'render date_in_future?' do
    travel_to '2001-01-03 10:00:00 +01:00' do
      render_inline(new_component(calendar_date: calendar_dates(:thursday)))
      assert_text 'Date in future'
    end
  end

  test 'render request_window_open_now?' do
    travel_to '2001-01-04 10:00:00 +01:00' do
      render_inline(new_component(calendar_date: calendar_dates(:thursday)))
      assert_text 'Collecting requests'
    end
  end

  test 'render requesting_light?' do
    travel_to '2001-01-04 16:35:00 +01:00' do
      render_inline(new_component(calendar_date: calendar_dates(:thursday)))
      assert_text 'Requesting light'
    end
  end

  test 'render light_requested?' do
    travel_to '2001-01-04 16:35:00 +01:00' do
      calendar_date = calendar_dates(:thursday)
      calendar_date.caretaker_informed!

      render_inline(new_component(calendar_date: calendar_date))
      assert_text 'Request sent to caretaker'
    end
  end

  test 'render no_light_confirmed?' do
    travel_to '2001-01-04 16:35:00 +01:00' do
      calendar_date = calendar_dates(:thursday)
      calendar_date.caretaker_informed!
      calendar_date.caretaker_confirmed_light!

      render_inline(new_component(calendar_date: calendar_date))
      assert_text 'Light confirmed'
    end
  end

  test 'render light_confirmed?' do
    travel_to '2001-01-04 16:35:00 +01:00' do
      calendar_date = calendar_dates(:thursday)
      calendar_date.caretaker_informed!
      calendar_date.caretaker_dismissed_light!

      render_inline(new_component(calendar_date: calendar_date))
      assert_text 'No light today'
      assert_text 'Light requests have been dismissed'
    end
  end
end
