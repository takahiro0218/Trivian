require "test_helper"

class Public::PostLiksControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get public_post_liks_index_url
    assert_response :success
  end
end
