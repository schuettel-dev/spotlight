require 'test_helper'

class CalendarServiceTest < ActiveSupport::TestCase
  test '.today_in_zurich, UTC is same day' do
    travel_to '2020-12-31T12:00:00+00:00' do
      assert_equal '2020-12-31', CalendarService.today_in_zurich.to_s
    end
  end

  test '.today_in_zurich, UTC is day before' do
    travel_to '2020-12-31T23:00:01+00:00' do
      assert_equal '2021-01-01', CalendarService.today_in_zurich.to_s
    end
  end

  test '.now_in_zurich' do
    travel_to '2020-12-31T12:00:00+00:00' do
      assert_equal '2020-12-31 13:00:00 +0100', CalendarService.now_in_zurich.to_s
    end

    travel_to '2020-12-31T23:00:00+00:00' do
      assert_equal '2021-01-01 00:00:00 +0100', CalendarService.now_in_zurich.to_s
    end

    travel_to '2020-06-30T23:00:00+00:00' do
      assert_equal '2020-07-01 01:00:00 +0200', CalendarService.now_in_zurich.to_s
    end
  end

  test '.all_day_in_zurich' do
    range = CalendarService.all_day_in_zurich(Date.new(2021, 12, 25))
    assert_equal '2021-12-25 00:00:00 +0100', range.begin.to_s
    assert_equal '2021-12-25 23:59:59 +0100', range.end.to_s
  end
end
