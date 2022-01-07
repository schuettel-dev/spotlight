require 'test_helper'

# rubocop:disable Layout/ExtraSpacing
class RequestWindowServiceTest < ActiveSupport::TestCase
  test '#request_window_starts_at and #request_window_ends_at, NO daylight savings' do
    # monday UTC+1
    new_service('2001-01-01').tap do |service|
      assert_equal zurich_time(2001, 1, 1,  0,  0, 0), service.request_window_starts_at
      assert_equal zurich_time(2001, 1, 1, 15,  0, 0), service.request_window_ends_at
    end

    # tuesday UTC+1
    new_service('2001-01-02').tap do |service|
      assert_equal zurich_time(2001, 1, 2,  0,  0, 0), service.request_window_starts_at
      assert_equal zurich_time(2001, 1, 2, 16,  0, 0), service.request_window_ends_at
    end

    # wednesday UTC+1
    new_service('2001-01-03').tap do |service|
      assert_equal zurich_time(2001, 1, 3,  0,  0, 0), service.request_window_starts_at
      assert_equal zurich_time(2001, 1, 3, 17,  0, 0), service.request_window_ends_at
    end

    # thursday UTC+1
    new_service('2001-01-04').tap do |service|
      assert_equal zurich_time(2001, 1, 4,  0,  0, 0), service.request_window_starts_at
      assert_equal zurich_time(2001, 1, 4, 16, 30, 0), service.request_window_ends_at
    end

    # friday UTC+1
    new_service('2001-01-05').tap do |service|
      assert_equal zurich_time(2001, 1, 5,  0,  0, 0), service.request_window_starts_at
      assert_equal zurich_time(2001, 1, 5, 14, 30, 0), service.request_window_ends_at
    end

    # saturday UTC+1
    new_service('2001-01-06').tap do |service|
      assert_equal zurich_time(2001, 1, 6,  0,  0, 0), service.request_window_starts_at
      assert_equal zurich_time(2001, 1, 6, 10,  0, 0), service.request_window_ends_at
    end

    # sunday UTC+1
    new_service('2001-01-07').tap do |service|
      assert_equal zurich_time(2001, 1, 7,  0,  0, 0), service.request_window_starts_at
      assert_equal zurich_time(2001, 1, 7,  0,  0, 0), service.request_window_ends_at
    end
  end

  test '#request_window_starts_at and #request_window_ends_at, daylight savings' do
    # monday UTC+2
    new_service('2009-06-01').tap do |service|
      assert_equal zurich_time(2009, 6, 1,  0,  0, 0), service.request_window_starts_at
      assert_equal zurich_time(2009, 6, 1, 15,  0, 0), service.request_window_ends_at
    end

    # tuesday UTC+2
    new_service('2009-06-02').tap do |service|
      assert_equal zurich_time(2009, 6, 2,  0,  0, 0), service.request_window_starts_at
      assert_equal zurich_time(2009, 6, 2, 16,  0, 0), service.request_window_ends_at
    end

    # wednesday UTC+2
    new_service('2009-06-03').tap do |service|
      assert_equal zurich_time(2009, 6, 3,  0,  0, 0), service.request_window_starts_at
      assert_equal zurich_time(2009, 6, 3, 17,  0, 0), service.request_window_ends_at
    end

    # thursday UTC+2
    new_service('2009-06-04').tap do |service|
      assert_equal zurich_time(2009, 6, 4,  0,  0, 0), service.request_window_starts_at
      assert_equal zurich_time(2009, 6, 4, 16, 30, 0), service.request_window_ends_at
    end

    # friday UTC+2
    new_service('2009-06-05').tap do |service|
      assert_equal zurich_time(2009, 6, 5,  0,  0, 0), service.request_window_starts_at
      assert_equal zurich_time(2009, 6, 5, 14, 30, 0), service.request_window_ends_at
    end

    # saturday UTC+2
    new_service('2009-06-06').tap do |service|
      assert_equal zurich_time(2009, 6, 6,  0,  0, 0), service.request_window_starts_at
      assert_equal zurich_time(2009, 6, 6, 10,  0, 0), service.request_window_ends_at
    end

    # sunday UTC+2
    new_service('2009-06-07').tap do |service|
      assert_equal zurich_time(2009, 6, 7,  0,  0, 0), service.request_window_starts_at
      assert_equal zurich_time(2009, 6, 7,  0,  0, 0), service.request_window_ends_at
    end
  end

  private

  def new_service(date)
    RequestWindowService.new(CalendarDate.new(date: date))
  end
end
# rubocop:enable Layout/ExtraSpacing
