require 'test_helper'

class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
  driven_by :rack_test

  def using_browser(&block)
    driver = ENV['DEBUG'].present? ? :selenium : :selenium_headless
    Capybara.using_driver(driver, &block)
  end

  def sign_in_as(fixture_key, password = '123456', locale: I18n.default_locale)
    user = users(fixture_key)
    visit new_user_session_path(locale: locale)
    within 'form' do
      fill_in 'Email', with: user.email
      fill_in 'Password', with: password
      check 'Remember me'
      click_on 'Log in'
    end
  end

  def navigate_to(user_menu_item)
    within '.user-menu' do
      find('.heroicon-menu').ancestor('button').click
      click_on user_menu_item
    end
  end
end
