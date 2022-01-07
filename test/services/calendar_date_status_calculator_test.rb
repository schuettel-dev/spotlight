require 'test_helper'

class CalendarDateStatusCalculatorTest < ActiveSupport::TestCase
  test 'date in future' do
    travel_to zurich_time(2001, 1, 1, 10, 0, 0) do
      assert_equal :date_in_future, status_for(CalendarDate.new(date: '2001-01-02'))
    end
  end

  test 'inactive days' do
    # saturday
    travel_to zurich_time(2001, 1, 6, 10, 0, 0) do
      assert_equal :not_active_today, status_for(CalendarDate.new(date: '2001-01-06'))
    end

    # sunday
    travel_to zurich_time(2001, 1, 7, 10, 0, 0) do
      assert_equal :not_active_today, status_for(CalendarDate.new(date: '2001-01-07'))
    end
  end

  test 'active day with requests, confirmed' do
    # Thursday, deadline 16:30
    calendar_date = calendar_dates(:thursday)

    travel_to zurich_time(2001, 1, 4, 16, 25, 0) do
      assert_equal :request_window_open_now, status_for(calendar_date)
    end

    travel_to zurich_time(2001, 1, 4, 16, 35, 0) do
      calendar_date.caretaker_informed_at = nil
      assert_equal :requesting_light, status_for(calendar_date)
      calendar_date.caretaker_informed_at = Time.zone.now
      assert_equal :light_requested, status_for(calendar_date)
    end

    travel_to zurich_time(2001, 1, 4, 16, 35, 0) do
      calendar_date.caretaker_confirmed_light!
      assert_equal :light_confirmed, status_for(calendar_date)
    end
  end

  test 'active day with requests, dismissed' do
    calendar_date = calendar_dates(:thursday)

    travel_to zurich_time(2001, 1, 4, 16, 35, 0) do
      calendar_date.caretaker_dismissed_light!
      assert_equal :light_dismissed, status_for(calendar_date)
    end
  end

  test 'active day without requests' do
    calendar_date = calendar_dates(:thursday)
    calendar_date.light_requests.delete_all

    travel_to zurich_time(2001, 1, 4, 16, 25, 0) do
      assert_equal :request_window_open_now, status_for(calendar_date)
    end

    travel_to zurich_time(2001, 1, 4, 16, 35, 0) do
      assert_equal :not_requested_until_deadline, status_for(calendar_date)
    end
  end

  test 'confirmed before deadline' do
    travel_to zurich_time(2001, 1, 4, 12, 25, 0) do
      calendar_date = calendar_dates(:thursday)
      calendar_date.caretaker_confirmed_light!

      assert_equal :light_confirmed, status_for(calendar_date)
    end
  end

  test 'dismissed before deadline' do
    travel_to zurich_time(2001, 1, 4, 12, 25, 0) do
      calendar_date = calendar_dates(:thursday)
      calendar_date.caretaker_dismissed_light!

      assert_equal :light_dismissed, status_for(calendar_date)
    end
  end

  private

  def status_for(calendar_date)
    CalendarDateStatusCalculator.new(calendar_date).status
  end
end
