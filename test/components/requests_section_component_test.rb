require 'test_helper'

class RequestsSectionComponentTest < ViewComponent::TestCase
  test 'render' do
    travel_to '2001-01-04 10:00:00 +01:00' do
      calendar_date = calendar_dates(:thursday)
      light_request = light_requests(:thursday_bart)

      render_inline(new_component(calendar_date: calendar_date, user_light_request: light_request))
      assert_selector 'h2', text: 'Requests'
      assert_selector '.section--body', text: 'There are 6 requests for today.'
      assert_selector '.section--footer', text: 'You have requested light for today'
      assert_button 'Revoke your light request.'
    end
  end

  test 'not render' do
    travel_to '2001-01-06 10:00:00 +01:00' do
      calendar_date = CalendarDate.find_or_create_for_today
      light_request = LightRequest.new

      component = new_component(calendar_date: calendar_date, user_light_request: light_request)

      assert_not component.render?
    end
  end
end
