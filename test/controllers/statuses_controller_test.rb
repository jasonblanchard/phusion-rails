require 'test_helper'

class StatusesControllerTest < ActionController::TestCase
  test "should get health" do
    get :health
    assert_response :success
  end

end
