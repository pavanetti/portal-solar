require 'test_helper'

class SearchControllerTest < ActionDispatch::IntegrationTest
  test "should post simple" do
    post search_simple_url
    assert_response :success
  end

  test "should post advanced" do
    post search_advanced_url
    assert_response :success
  end

end
