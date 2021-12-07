require 'test_helper'

class LightRequestsControllerTest < ActionDispatch::IntegrationTest
  test '#create, logged out' do
    assert_no_difference -> { LightRequest.count } do
      post light_requests_path, params: {}
    end

    follow_redirect!
    assert_response :success

    assert_equal 'You need to sign in or sign up before continuing.', flash[:alert]
  end

  test '#destroy, logged out' do
    travel_to '2001-01-01 10:00:00 +01:00' do
      light_request = light_requests(:monday_bart)

      assert_no_difference -> { LightRequest.count } do
        delete light_request_path(light_request), params: {}
      end

      follow_redirect!
      assert_response :success

      assert_equal 'You need to sign in or sign up before continuing.', flash[:alert]
    end
  end

  test '#create, logged in, request window open' do
    travel_to '2001-01-04 10:00:00 +01:00' do
      user = users(:martin)
      sign_in_as user

      assert_difference -> { user.light_requests.count }, +1 do
        post light_requests_path, params: {}
      end

      follow_redirect!
      assert_response :success
    end
  end

  test '#create, logged in, request window closed' do
    travel_to '2001-01-04 16:35:00 +01:00' do
      user = users(:martin)
      sign_in_as user

      assert_no_difference -> { LightRequest.count } do
        post light_requests_path, params: {}
      end

      follow_redirect!
      assert_response :success

      assert_equal 'Light could not be requested.', flash[:alert]
    end
  end

  test '#destroy, logged in, request window open' do
    travel_to '2001-01-04 10:00:00 +01:00' do
      user = users(:bart)
      light_request = light_requests(:thursday_bart)
      sign_in_as user

      assert_difference -> { user.light_requests.count }, -1 do
        delete light_request_path(light_request), params: {}
      end

      follow_redirect!
      assert_response :success
    end
  end

  test '#destroy, logged in, request window closed' do
    travel_to '2001-01-04 16:35:00 +01:00' do
      user = users(:bart)
      light_request = light_requests(:thursday_bart)
      sign_in_as user

      assert_no_difference -> { user.light_requests.count } do
        delete light_request_path(light_request), params: {}
      end

      follow_redirect!
      assert_response :success
    end
  end
end
