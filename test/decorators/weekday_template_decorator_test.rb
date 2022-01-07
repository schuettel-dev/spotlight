require 'test_helper'

class WeekdayTemplateDecoratorTest < ActiveSupport::TestCase
  test '#display_weekday' do
    assert_equal 'Monday', decorate(:monday).display_weekday
  end

  test '#display_request_window_starts_at' do
    assert_equal '00:00', decorate(:monday).display_request_window_starts_at
  end

  test '#display_request_window_ends_at' do
    assert_equal '15:00', decorate(:monday).display_request_window_ends_at
  end

  private

  def decorate(key)
    WeekdayTemplateDecorator.new(weekday_templates(key))
  end
end
