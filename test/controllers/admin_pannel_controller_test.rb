require 'test_helper'

class AdminPannelControllerTest < ActionDispatch::IntegrationTest
  test "should get home" do
    get admin_pannel_home_url
    assert_response :success
  end

end
