require 'test_helper'

class Admin::RequestDeadlinesControllerTest < ActionDispatch::IntegrationTest
  test 'PUT update' do
    sign_in(users(:marge))

    request_deadline = request_deadlines(:monday)

    assert_changes -> { request_deadline.active? }, to: false do
      assert_changes -> { I18n.l(request_deadline.time, format: :day_time_only) }, to: '11:00' do
        put admin_request_deadline_path(request_deadline),
            params: { request_deadline: { active: '0', time: '11:00' } }
        request_deadline.reload
      end
    end

    follow_redirect!
    assert_response :success
  end

  test 'cannot PUT update, if not admin' do
    sign_in(users(:bart))

    request_deadline = request_deadlines(:monday)

    assert_no_changes -> { request_deadline.updated_at } do
      put admin_request_deadline_path(request_deadline),
          params: { request_deadline: { active: '0', time: '11:00' } }
      request_deadline.reload
    end

    follow_redirect!
    assert_response :success

    assert_equal 'Only admins can access this.', flash[:alert]
  end
end
