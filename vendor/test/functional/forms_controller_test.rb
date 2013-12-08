require 'test_helper'

class FormsControllerTest < ActionController::TestCase
  test "should get invitation" do
    get :invitation
    assert_response :success
  end

  test "should get registration" do
    get :registration
    assert_response :success
  end

end
