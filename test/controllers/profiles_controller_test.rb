require 'test_helper'

class ProfilesControllerTest < ActionDispatch::IntegrationTest
  test 'guest should NOT get show' do
    get profile_path
    assert_access_denied 'You need to sign in or sign up before continuing.'
  end

  test 'user should get show' do
    sign_in users(:bart)
    get profile_path
    assert_response :success
  end

  test 'guest should NOT put update' do
    get profile_path
    assert_access_denied 'You need to sign in or sign up before continuing.'
  end

  test 'user should put update' do
    user = users(:bart)
    sign_in user

    put profile_path, params: { user: { mobile: '00417900011122', locale: 'de' } }
    follow_redirect!
    assert_response :success
    assert_equal 'Profil wurde aktualisiert.', flash[:notice]

    user.reload

    assert_equal '00417900011122', user.mobile
    assert_equal 'de', user.locale
  end
end
