require 'test_helper'

class CalendarDateTest < ActiveSupport::TestCase
  test '.find_or_create_for_today' do
    travel_to '2021-01-01' do
      CalendarDate.find_or_create_for_today.tap do |calendar_date|
        assert_equal '2021-01-01', calendar_date.date.to_s
        assert calendar_date.active?
        assert_equal '2020-12-31 23:00:00 UTC', calendar_date.request_window_starts_at.to_s
        assert_equal '2021-01-01 13:30:00 UTC', calendar_date.request_window_ends_at.to_s
        assert_equal '2021-01-01 15:47:39 UTC', calendar_date.sun_sets_at.to_s
        assert calendar_date.persisted?
      end
    end
  end

  test '.find_or_create_for_today, daylight saving' do
    travel_to '2021-06-14' do
      CalendarDate.find_or_create_for_today.tap do |calendar_date|
        assert_equal '2021-06-14', calendar_date.date.to_s
        assert calendar_date.active?
        assert_equal '2021-06-13 22:00:00 UTC', calendar_date.request_window_starts_at.to_s
        assert_equal '2021-06-14 13:00:00 UTC', calendar_date.request_window_ends_at.to_s
        assert_equal '2021-06-14 19:25:40 UTC', calendar_date.sun_sets_at.to_s
        assert calendar_date.persisted?
      end
    end
  end

  test '.find_or_create_for_today, not active' do
    travel_to '2001-01-07' do
      CalendarDate.find_or_create_for_today.tap do |calendar_date|
        assert_equal '2001-01-07', calendar_date.date.to_s
        assert_not calendar_date.active?, 'Calendar date should not be active since it is a sunday'
        assert calendar_date.persisted?
      end
    end
  end

  test '#caretaker_informed? and #caretaker_informed!' do
    calendar_date = calendar_dates(:thursday)

    assert_changes -> { calendar_date.caretaker_informed? }, to: true do
      calendar_date.caretaker_informed!
    end
  end

  test '#caretaker_confirmed_light? and caretaker_confirmed_light!' do
    calendar_date = calendar_dates(:wednesday)

    assert_changes -> { calendar_date.caretaker_confirmed_light? }, to: true do
      calendar_date.caretaker_confirmed_light!
    end
  end

  test '#caretaker_dismissed_light? and #caretaker_dismissed_light!' do
    calendar_date = calendar_dates(:wednesday)

    assert_changes -> { calendar_date.caretaker_dismissed_light? }, to: true do
      calendar_date.caretaker_dismissed_light!
    end
  end

  test '#reset_caretaker_decision!, confirmed' do
    calendar_date = calendar_dates(:monday)
    assert_changes -> { calendar_date.caretaker_confirmed_light? }, to: false do
      assert_no_changes -> { calendar_date.caretaker_dismissed_light? } do
        calendar_date.reset_caretaker_decision!
      end
    end
  end

  test '#reset_caretaker_decision!, dismissed' do
    calendar_date = calendar_dates(:monday)
    calendar_date.caretaker_dismissed_light!

    assert_changes -> { calendar_date.caretaker_dismissed_light? }, to: false do
      assert_no_changes -> { calendar_date.caretaker_confirmed_light? } do
        calendar_date.reset_caretaker_decision!
      end
    end
  end

  test '#request_window_open_at?' do
    calendar_date = calendar_dates(:tuesday)

    assert_not calendar_date.request_window_open_at?(DateTime.parse('2001-01-01 23:59:59 UTC+1'))
    assert calendar_date.request_window_open_at?(DateTime.parse('2001-01-02 00:00:00 UTC+1'))
    assert calendar_date.request_window_open_at?(DateTime.parse('2001-01-02 16:00:00 UTC+1'))
    assert_not calendar_date.request_window_open_at?(DateTime.parse('2001-01-02 16:00:01 UTC+1'))
  end
end
