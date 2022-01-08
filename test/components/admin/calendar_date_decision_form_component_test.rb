require 'test_helper'

class Admin::CalendarDateDecisionFormComponentTest < ViewComponent::TestCase
  test '#render, caretaker undecided' do
    render_inline(new_component(current_user: users(:willie), calendar_date: calendar_dates(:thursday)))

    assert_button 'Confirm'
    assert_button 'Dismiss'
  end

  test '#render, caretaker decided' do
    render_inline(new_component(current_user: users(:willie), calendar_date: calendar_dates(:monday)))

    assert_button 'Revoke decision'
  end

  test '#render, not if not caretaker' do
    component = new_component(current_user: users(:marge), calendar_date: calendar_dates(:thursday))
    assert_not component.render?
  end
end
