require 'test_helper'

class CalendarDateTest < ActiveSupport::TestCase
  test '.for_today' do
    travel_to '2021-01-01' do
      CalendarDate.for_today.tap do |calendar_date|
        assert_equal '2021-01-01', calendar_date.date.to_s
        assert_not calendar_date.persisted?
        assert_equal 0, calendar_date.light_requests_count
      end
    end
  end

  test 'enum :statuses' do
    assert_equal 4, CalendarDate.statuses.count
    assert CalendarDate.new.collecting_requests?
  end
end
