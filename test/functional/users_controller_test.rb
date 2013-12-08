require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  test "should get users_list" do
    get :users_list
    assert_response :success
  end

  test "should get charts" do
    get :charts
    assert_response :success
  end

end
