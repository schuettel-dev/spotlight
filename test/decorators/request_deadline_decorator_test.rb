require 'test_helper'

class RequestDeadlineDecoratorTest < ActiveSupport::TestCase
  test '#display_weekday' do
    assert_equal 'Monday', RequestDeadlineDecorator.new(request_deadlines(:monday)).display_weekday
  end

  test '#display_time' do
    assert_equal '15:00', RequestDeadlineDecorator.new(request_deadlines(:monday)).display_time
  end
end
