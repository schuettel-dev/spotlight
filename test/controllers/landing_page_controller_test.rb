require "test_helper"

class LandingPageControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get landing_page_show_url
    assert_response :success
  end
end
