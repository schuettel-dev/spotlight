require 'test_helper'

class RevokeRequestComponentTest < ViewComponent::TestCase
  test 'render' do
    travel_to '2001-01-04 10:00:00 +01:00' do
      light_request = light_requests(:thursday_bart)
      calendar_date = calendar_dates(:thursday)

      component = new_component(calendar_date: calendar_date, user_light_request: light_request)

      render_inline component

      assert_text 'You have requested light for today.'
      assert_button 'Revoke your light request.'
    end
  end

  test 'not render, not awaiting light requests' do
    travel_to '2001-01-04 16:35:00 +01:00' do
      light_request = light_requests(:thursday_bart)
      calendar_date = calendar_dates(:thursday)

      component = new_component(calendar_date: calendar_date, user_light_request: light_request)

      assert_not component.render?
    end
  end

  test 'not render, light request not persisted' do
    travel_to '2001-01-04 10:00:00 +01:00' do
      light_request = users(:martin).light_request_for_today
      calendar_date = calendar_dates(:thursday)

      component = new_component(calendar_date: calendar_date, user_light_request: light_request)

      assert_not component.render?
    end
  end
end
