require 'test_helper'

class MainControllerTest < ActionController::TestCase
  test "should get profile" do
    get :profile
    assert_response :success
  end

  test "should get send_chips" do
    get :send_chips
    assert_response :success
  end

  test "should get leaderboard" do
    get :leaderboard
    assert_response :success
  end

end
