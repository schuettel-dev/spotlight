ENV["RAILS_ENV"] ||= "test"
require_relative "../config/environment"
require "rails/test_help"

class ActiveSupport::TestCase
  # Run tests in parallel with specified workers
  parallelize(workers: :number_of_processors)

  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...
  def zurich_time(*args)
    DateTime.new(*args).asctime.in_time_zone('Europe/Zurich')
  end

  def to_day_time_only(date)
    I18n.l(date, format: :day_time_only)
  end

  def a_monday()    = Date.new(2001, 1, 1)
  def a_tuesday()   = Date.new(2001, 1, 2)
  def a_wednesday() = Date.new(2001, 1, 3)
  def a_thursday()  = Date.new(2001, 1, 4)
  def a_friday()    = Date.new(2001, 1, 5)
  def a_saturday()  = Date.new(2001, 1, 6)
  def a_sunday()    = Date.new(2001, 1, 7)
end

class ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  def sign_in_as(fixture, password: '123456')
    sign_in(fixture)
  end
end
