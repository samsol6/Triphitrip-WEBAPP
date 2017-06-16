require 'test_helper'

class Api::ApiControllerTest < ActionDispatch::IntegrationTest
  test "should get current_user" do
    get api_api_current_user_url
    assert_response :success
  end

end
