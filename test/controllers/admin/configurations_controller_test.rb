require 'test_helper'

class Admin::ConfigurationsControllerTest < ActionDispatch::IntegrationTest
  # get show
  test 'guest does not get #edit' do
    get admin_configuration_path
    assert_access_denied 'You need to sign in or sign up before continuing.'
  end

  test 'user does not get #edit' do
    sign_in(users(:todd))
    get admin_configuration_path
    assert_access_denied 'Only admins can access this.'
  end

  test 'admin get #edit' do
    sign_in(users(:marge))
    get admin_configuration_path
    assert_response :success
  end

  private

  def assert_access_denied(alert_message)
    follow_redirect!
    assert_response :success
    assert_equal alert_message, flash[:alert]
  end
end
