require 'test_helper'

class CalendarServiceTest < ActiveSupport::TestCase
  test '.today_in_time_zone, UTC is same day' do
    travel_to '2020-12-31T12:00:0+00:00' do
      assert_equal '2020-12-31', CalendarService.today_in_time_zone.to_s
    end
  end

  test '.today_in_time_zone, UTC is day before' do
    travel_to '2020-12-31T23:00:01+00:00' do
      assert_equal '2021-01-01', CalendarService.today_in_time_zone.to_s
    end
  end

  test '.now_in_time_zone'
  test '.all_day_in_time_zone'
end
