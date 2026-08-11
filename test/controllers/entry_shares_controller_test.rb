require "test_helper"

class EntrySharesControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get entry_shares_create_url
    assert_response :success
  end

  test "should get destroy" do
    get entry_shares_destroy_url
    assert_response :success
  end
end
