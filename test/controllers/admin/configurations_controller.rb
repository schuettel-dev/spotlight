require 'test_helper'

class Admin::ConfigurationsControllerTest < ActionDispatch::IntegrationTest
  # get edit
  test 'guest does not get #edit' do
    get edit_admin_configuration_path
    assert_access_denied 'You need to sign in or sign up before continuing.'
  end

  test 'user does not get #edit' do
    sign_in(users(:todd))
    get edit_admin_configuration_path
    assert_access_denied 'Only admins can access this.'
  end

  test 'admin get #edit' do
    sign_in(users(:marge))
    get edit_admin_configuration_path
    assert_response :success
  end

  # patch update
  test 'guest does not patch #update' do
    patch admin_configuration_path, params: {}
    assert_access_denied 'You need to sign in or sign up before continuing.'
  end

  test 'user does not patch #update' do
    sign_in(users(:todd))
    patch admin_configuration_path, params: {}
    assert_access_denied 'Only admins can access this.'
  end

  test 'admin patch #update' do
    patch admin_configuration_path, params: {}
    follow_redirect!
    assert_response :success
    skip 'todo'
  end

  private

  def assert_access_denied(alert_message)
    follow_redirect!
    assert_response :success
    assert_equal alert_message, flash[:alert]
  end
end
