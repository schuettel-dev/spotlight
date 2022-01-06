require 'test_helper'

class CalendarDateDecoratorTest < ActiveSupport::TestCase
  test '#display_date' do
    assert_equal 'January 01, 2001', calendar_dates(:monday).decorate.display_date
  end

  test '#display_sun_sets_at' do
    assert_equal '16:47', calendar_dates(:monday).decorate.display_sun_sets_at
  end

  test '#display_status' do
    assert_equal 'Light confirmed', calendar_dates(:monday).decorate.display_status
  end

  test '#display_light_requests_with_count' do
    assert_equal '9 light requests', calendar_dates(:monday).decorate.display_light_requests_with_count
  end
end
