require 'test_helper'

class RequestDeadlineTest < ActiveSupport::TestCase
  test '.for_date' do
    assert_equal '15:00', to_day_time_only(RequestDeadline.for_date(a_monday).time)
    assert_equal '16:00', to_day_time_only(RequestDeadline.for_date(a_tuesday).time)
    assert_equal '17:00', to_day_time_only(RequestDeadline.for_date(a_wednesday).time)
    assert_equal '16:30', to_day_time_only(RequestDeadline.for_date(a_thursday).time)
    assert_equal '14:30', to_day_time_only(RequestDeadline.for_date(a_friday).time)
    assert_equal '10:00', to_day_time_only(RequestDeadline.for_date(a_saturday).time)
    assert_equal '00:00', to_day_time_only(RequestDeadline.for_date(a_sunday).time)
  end

  test '.for_today' do
    travel_to a_wednesday do
      assert_equal '17:00', to_day_time_only(RequestDeadline.for_today.time)
    end
  end

  test '#update_time' do
    thursday_deadline = request_deadlines(:thursday)
    assert_changes -> { to_day_time_only(thursday_deadline.time) },
                   from: '16:30', to: '13:00' do
      thursday_deadline.update_time('13:00')
    end
  end
end
