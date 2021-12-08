require 'test_helper'

class LightRequestTest < ActiveSupport::TestCase
  test 'valid' do
    travel_to '2001-01-04 16:25:00 +01:00' do
      light_request = LightRequest.new(calendar_date: calendar_dates(:thursday),
                                       user: users(:martin))
      assert light_request.valid?
    end
  end

  test 'invalid, active, request window not open' do
    travel_to '2001-01-04 16:35:00 +01:00' do
      light_request = LightRequest.new(calendar_date: calendar_dates(:thursday),
                                       user: users(:martin))
      assert_not light_request.valid?

      assert_includes light_request.errors.to_a, 'Request window is closed.'
    end
  end

  test 'invalid, not active' do
    travel_to '2001-01-06 10:00:00 +01:00' do
      light_request = LightRequest.new(calendar_date: calendar_dates(:thursday),
                                       user: users(:martin))
      assert_not light_request.valid?

      assert_includes light_request.errors.to_a, 'Request window is closed.'
    end
  end
end
