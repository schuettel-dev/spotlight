require 'test_helper'

class WeekdayTemplateTest < ActiveSupport::TestCase
  test '.for_date' do
    assert_equal 1, WeekdayTemplate.for_date(a_monday).weekday
    assert_equal 2, WeekdayTemplate.for_date(a_tuesday).weekday
    assert_equal 3, WeekdayTemplate.for_date(a_wednesday).weekday
    assert_equal 4, WeekdayTemplate.for_date(a_thursday).weekday
    assert_equal 5, WeekdayTemplate.for_date(a_friday).weekday
    assert_equal 6, WeekdayTemplate.for_date(a_saturday).weekday
    assert_equal 0, WeekdayTemplate.for_date(a_sunday).weekday
  end

  test '#set_request_window_ends_at with blank' do
    weekday_template = weekday_templates(:monday)
    assert_no_changes -> { weekday_template.request_window_ends_at } do
      weekday_template.set_request_window_ends_at('')
      weekday_template.reload
    end
  end

  test '#update_request_window_ends_at' do
    weekday_template = weekday_templates(:thursday)
    assert_changes -> { to_day_time_only(weekday_template.request_window_ends_at) },
                   from: '16:30', to: '13:00' do
      weekday_template.update_request_window_ends_at('13:00')
      weekday_template.reload
    end
  end

  test '#toggle_active!' do
    weekday_template = weekday_templates(:monday)
    assert_changes -> { weekday_template.active? }, to: false do
      weekday_template.toggle_active!
      weekday_template.reload
    end

    assert_changes -> { weekday_template.active? }, to: true do
      weekday_template.toggle_active!
      weekday_template.reload
    end
  end
end
