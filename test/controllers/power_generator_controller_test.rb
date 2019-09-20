require 'test_helper'

class PowerGeneratorControllerTest < ActionDispatch::IntegrationTest
  test "should get all power generators" do
    get power_generators_url
    assert_response :success
  end

  test "should get power generators by simple query search" do
    get power_generators_url, params: {:query => 'YC600i'}
    assert_response :success
  end

end
