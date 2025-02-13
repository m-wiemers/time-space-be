require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get users_index_url
    assert_response :success
  end

  test "should get creaTE" do
    get users_creaTE_url
    assert_response :success
  end
end
