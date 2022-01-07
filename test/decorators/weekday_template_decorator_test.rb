require 'test_helper'

class WeekdayTemplateDecoratorTest < ActiveSupport::TestCase
  test '#display_weekday' do
    assert_equal 'Monday', WeekdayTemplateDecorator.new(weekday_templates(:monday)).display_weekday
  end

  test '#display_time' do
    assert_equal '15:00', WeekdayTemplateDecorator.new(weekday_templates(:monday)).display_time
  end
end
