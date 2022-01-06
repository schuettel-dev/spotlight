require 'test_helper'

class CalendarDateDecoratorTest < ActiveSupport::TestCase
  test '#display_date' do
    assert_equal 'January 01, 2001', CalendarDateDecorator.new(calendar_dates(:monday)).display_date
  end

  test '#display_sun_sets_at' do
    assert_equal '16:47', CalendarDateDecorator.new(calendar_dates(:monday)).display_sun_sets_at
  end
end
