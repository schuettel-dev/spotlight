require 'test_helper'

class Admin::UsersControllerTest < ActionDispatch::IntegrationTest
  test 'guest cannot GET #index' do
    get admin_users_path
    assert_access_denied 'You need to sign in or sign up before continuing.'
  end

  test 'user cannot GET #index' do
    sign_in(users(:bart))
    get admin_users_path
    assert_access_denied 'Only admins can access this.'
  end

  test 'admin GET #index' do
    sign_in(users(:marge))
    get admin_users_path
    assert_response :success
  end

  # general update
  test 'guest cannot PUT #update' do
    user = users(:bart)

    assert_no_changes -> { user.status } do
      put admin_user_path(user), params: {}
      user.reload
    end

    assert_access_denied 'You need to sign in or sign up before continuing.'
  end

  test 'user cannot PUT #update' do
    sign_in(users(:bart))

    user = users(:bart)

    assert_no_changes -> { user.status } do
      put admin_user_path(user), params: {}
      user.reload
    end

    assert_access_denied 'Only admins can access this.'
  end

  # admin updates status
  test 'admin PUT #update, status: :unverified' do
    sign_in(users(:marge))

    user = users(:bart)

    assert_changes -> { user.status }, to: 'unverified' do
      put admin_user_path(user), params: { user: { status: :unverified } }
      user.reload
    end

    follow_redirect!
    assert_equal 'User updated successfully.', flash[:notice]
  end

  test 'admin PUT #update, status: :verified' do
    sign_in(users(:marge))
    user = users(:milhouse)

    assert_changes -> { user.status }, to: 'verified' do
      put admin_user_path(user), params: { user: { status: :verified } }
      user.reload
    end

    follow_redirect!
    assert_equal 'User updated successfully.', flash[:notice]
  end

  test 'admin PUT #update, status: :blocked' do
    sign_in(users(:marge))
    user = users(:milhouse)

    assert_changes -> { user.status }, to: 'blocked' do
      put admin_user_path(user), params: { user: { status: :blocked } }
      user.reload
    end

    follow_redirect!
    assert_equal 'User updated successfully.', flash[:notice]
  end

  test 'admin PUT #update, invalid status' do
    sign_in(users(:marge))
    user = users(:milhouse)

    assert_raises(ArgumentError) do
      put admin_user_path(user), params: { user: { status: :does_not_exists } }
    end
  end

  test 'admin PUT #update, cannot change status for admins' do
    sign_in(users(:marge))

    user = users(:ned)

    assert_no_changes -> { user.status } do
      put admin_user_path(user), params: { user: { status: :blocked } }
      user.reload
    end

    follow_redirect!
    assert_equal 'There was a problem updating the user.', flash[:alert]
  end

  # admin updates role
  test 'admin cannot PUT #update, change role if not verified' do
    sign_in(users(:marge))

    user = users(:milhouse)

    assert_no_changes -> { user.role } do
      put admin_user_path(user), params: { user: { role: :admin } }
      user.reload
    end

    follow_redirect!
    assert_equal 'There was a problem updating the user.', flash[:alert]
  end

  test 'admin PUT #update, change verified user to admin' do
    sign_in(users(:marge))

    user = users(:bart)

    assert_changes -> { user.role }, to: 'admin' do
      put admin_user_path(user), params: { user: { role: :admin } }
      user.reload
    end

    follow_redirect!
    assert_equal 'User updated successfully.', flash[:notice]
  end

  test 'admin PUT #update, change verified user to caretaker' do
    sign_in(users(:marge))

    user = users(:bart)

    assert_changes -> { user.role }, to: 'caretaker' do
      put admin_user_path(user), params: { user: { role: :caretaker } }
      user.reload
    end

    follow_redirect!
    assert_equal 'User updated successfully.', flash[:notice]
  end

  test 'admin PUT #update, change admin to user' do
    sign_in(users(:marge))

    user = users(:ned)

    assert_changes -> { user.role }, to: 'user' do
      put admin_user_path(user), params: { user: { role: :user } }
      user.reload
    end

    follow_redirect!
    assert_equal 'User updated successfully.', flash[:notice]
  end

  test 'admin cannot PUT #update, change verified user to superadmin' do
    sign_in(users(:marge))

    user = users(:marge)

    assert_no_changes -> { user.role } do
      put admin_user_path(user), params: { user: { role: :superadmin } }
      user.reload
    end

    follow_redirect!
    assert_equal 'There was a problem updating the user.', flash[:alert]
  end
end
