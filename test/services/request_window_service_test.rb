require 'test_helper'

class RequestWindowServiceTest < ActiveSupport::TestCase
  test '#open?, no daylight savings' do
    # monday UTC+1
    assert_not_window_open_at zurich_time(2000, 12, 31, 23, 55, 0), calendar_dates(:monday)
    assert_window_open_at     zurich_time(2001,  1,  1,  0,  0, 0), calendar_dates(:monday)
    assert_window_open_at     zurich_time(2001,  1,  1, 14, 55, 0), calendar_dates(:monday)
    assert_not_window_open_at zurich_time(2001,  1,  1, 15,  5, 0), calendar_dates(:monday)

    # tuesday UTC+1
    assert_not_window_open_at zurich_time(2001,  1,  1, 23, 55, 0), calendar_dates(:tuesday)
    assert_window_open_at     zurich_time(2001,  1,  2,  0,  0, 0), calendar_dates(:tuesday)
    assert_window_open_at     zurich_time(2001,  1,  2, 15, 55, 0), calendar_dates(:tuesday)
    assert_not_window_open_at zurich_time(2001,  1,  2, 16,  5, 0), calendar_dates(:tuesday)

    # wednesday UTC+1
    assert_not_window_open_at zurich_time(2001,  1,  2, 23, 55, 0), calendar_dates(:wednesday)
    assert_window_open_at     zurich_time(2001,  1,  3,  0,  0, 0), calendar_dates(:wednesday)
    assert_window_open_at     zurich_time(2001,  1,  3, 16, 55, 0), calendar_dates(:wednesday)
    assert_not_window_open_at zurich_time(2001,  1,  3, 17,  5, 0), calendar_dates(:wednesday)

    # thursday UTC+1
    assert_not_window_open_at zurich_time(2001,  1,  3, 23, 55, 0), calendar_dates(:thursday)
    assert_window_open_at     zurich_time(2001,  1,  4,  0,  0, 0), calendar_dates(:thursday)
    assert_window_open_at     zurich_time(2001,  1,  4, 16, 25, 0), calendar_dates(:thursday)
    assert_not_window_open_at zurich_time(2001,  1,  4, 16, 35, 0), calendar_dates(:thursday)

    # friday UTC+1
    assert_not_window_open_at zurich_time(2001,  1,  4, 23, 55, 0), CalendarDate.new(date: '2001-01-05')
    assert_window_open_at     zurich_time(2001,  1,  5, 14, 25, 0), CalendarDate.new(date: '2001-01-05')
    assert_window_open_at     zurich_time(2001,  1,  5,  0,  0, 0), CalendarDate.new(date: '2001-01-05')
    assert_not_window_open_at zurich_time(2001,  1,  5, 14, 35, 0), CalendarDate.new(date: '2001-01-05')

    # saturday UTC+1
    assert_not_window_open_at zurich_time(2001,  1,  6,  0,  5, 0), CalendarDate.new(date: '2001-01-06')

    # sunday UTC+1
    assert_not_window_open_at zurich_time(2001,  1,  7,  0,  5, 0), CalendarDate.new(date: '2001-01-07')
  end

  test '#open?, daylight savings' do
    # monday UTC+2
    assert_window_open_at     zurich_time(2009, 6, 1, 14, 55, 0)
    assert_not_window_open_at zurich_time(2009, 6, 1, 15,  5, 0)

    # tuesday UTC+2
    assert_window_open_at     zurich_time(2009, 6, 2, 15, 55, 0)
    assert_not_window_open_at zurich_time(2009, 6, 2, 16,  5, 0)

    # wednesday UTC+2
    assert_window_open_at     zurich_time(2009, 6, 3, 16, 55, 0)
    assert_not_window_open_at zurich_time(2009, 6, 3, 17,  5, 0)

    # thursday UTC+2
    assert_window_open_at     zurich_time(2009, 6, 4, 16, 25, 0)
    assert_not_window_open_at zurich_time(2009, 6, 4, 16, 35, 0)

    # friday UTC+2
    assert_window_open_at     zurich_time(2009, 6, 5, 14, 25, 0)
    assert_not_window_open_at zurich_time(2009, 6, 5, 14, 35, 0)

    # saturday UTC+2
    assert_not_window_open_at zurich_time(2009, 6, 6,  0,  5, 0)

    # sunday UTC+2
    assert_not_window_open_at zurich_time(2009, 6, 7,  0,  5, 0)
  end

  private

  def assert_window_open_at(reference_time, calendar_date)
    travel_to reference_time do
      assert RequestWindowService.new(calendar_date).open?
    end
  end

  def assert_not_window_open_at(reference_time, calendar_date)
    travel_to reference_time do
      assert_not RequestWindowService.new(calendar_date).open?
    end
  end
end
