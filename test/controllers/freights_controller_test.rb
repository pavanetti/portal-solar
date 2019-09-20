require 'test_helper'

class FreightsControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    id = PowerGenerator.take.id
    get "/freights/SP?generator=#{id}"
    assert_response :success
  end

end
