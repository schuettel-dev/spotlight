require 'test_helper'

class Admin::CalendarDateActivationFormComponentTest < ViewComponent::TestCase
  test '#render, active calendar date' do
    calendar_date = calendar_dates(:friday)

    travel_to '2001-01-05 10:00:00' do
      render_inline new_component(calendar_date: calendar_date)
      assert_button 'Deactivate'
    end
  end

  test '#render, inactive calendar date' do
    calendar_date = calendar_dates(:friday)
    calendar_date.update(active: false)

    travel_to '2001-01-05 10:00:00' do
      render_inline new_component(calendar_date: calendar_date)
      assert_button 'Activate'
    end
  end

  test 'not #render' do
    component = new_component(calendar_date: calendar_dates(:thursday))
    assert_not component.render?, 'should not render because there are light requests already'
  end
end
