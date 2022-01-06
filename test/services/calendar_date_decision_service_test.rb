require 'test_helper'

class CalendarDateDecisionServiceTest < ActiveSupport::TestCase
  test 'confirm' do
    calendar_date = calendar_dates(:thursday)

    assert_changes -> { calendar_date.caretaker_confirmed_light? }, to: true do
      CalendarDateDecisionService.new(calendar_date, :confirm).call
    end
  end

  test 'dismiss' do
    calendar_date = calendar_dates(:thursday)

    assert_changes -> { calendar_date.caretaker_dismissed_light? }, to: true do
      CalendarDateDecisionService.new(calendar_date, :dismiss).call
    end
  end

  test 'reset decided' do
    calendar_date = calendar_dates(:monday)

    assert_changes -> { calendar_date.caretaker_confirmed_light? }, to: false do
      CalendarDateDecisionService.new(calendar_date, :reset).call
    end
  end
end
