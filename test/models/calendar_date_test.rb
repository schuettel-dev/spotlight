require 'test_helper'

class CalendarDateTest < ActiveSupport::TestCase
  test '.for_today' do
    travel_to '2021-01-01' do
      CalendarDate.for_today.tap do |calendar_date|
        assert_equal '2021-01-01', calendar_date.date.to_s
        assert_not calendar_date.persisted?
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
end
