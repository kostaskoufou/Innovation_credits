require 'test_helper'

class DeleteControllerTest < ActionController::TestCase
  test "should get help" do
    get :help
    assert_response :success
  end

  test "should get user" do
    get :user
    assert_response :success
  end

end
