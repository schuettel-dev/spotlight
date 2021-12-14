require 'test_helper'

class RequestButtonComponentTest < ViewComponent::TestCase

  setup do
    @thursday = calendar_dates(:thursday)
    @thursday.update!(caretaker_informed_at: nil)
    @martin = users(:martin)
    @martins_light_request = @thursday.light_requests.new(user: @martin)
  end

  test '#render, new light_request' do
    travel_to '2001-01-04 12:00:00 +01:00' do
      component = new_component(calendar_date: @thursday, user_light_request: @martins_light_request)
      render_inline(component)

      assert_button 'Request light'
    end
  end

  test '#render, light request not associated to a users (= not signed in)' do
    travel_to '2001-01-04 12:00:00 +01:00' do
      component = new_component(calendar_date: @thursday, user_light_request: LightRequest.new)
      render_inline(component)

      assert_button 'Request light', count: 0
      assert_link 'Sign in to request light'
    end
  end

  test 'not render' do
    travel_to '2001-01-03 23:59:59 +01:00' do
      component = new_component(calendar_date: @thursday, user_light_request: @martins_light_request)
      assert_not component.render?, 'should not render because it is too early'
    end

    travel_to '2001-01-04 00:00:01 +01:00' do
      @thursday.reset_status
      component = new_component(calendar_date: @thursday, user_light_request: @martins_light_request)
      assert component.render?, 'should render: time window is open and light request is not persisted'

      @martins_light_request.save!
      @thursday.reset_status

      component = new_component(calendar_date: @thursday, user_light_request: @martins_light_request)
      assert_not component.render?, 'should not render because light request is persisted'
    end
  end
end
