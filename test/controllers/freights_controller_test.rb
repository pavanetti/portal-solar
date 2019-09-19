require 'test_helper'

class FreightsControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get freights_show_url
    assert_response :success
  end

end
