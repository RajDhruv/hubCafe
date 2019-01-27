require 'test_helper'

class MessagesControllerTest < ActionDispatch::IntegrationTest
  test "should get show_users" do
    get messages_show_users_url
    assert_response :success
  end

  test "should get get_messages" do
    get messages_get_messages_url
    assert_response :success
  end

  test "should get delete" do
    get messages_delete_url
    assert_response :success
  end

end
