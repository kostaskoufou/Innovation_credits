require 'test_helper'

class HelpControllerTest < ActionController::TestCase
  test "should get request_help" do
    get :request_help
    assert_response :success
  end

end
