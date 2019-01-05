require 'test_helper'

class CafesControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get cafes_new_url
    assert_response :success
  end

  test "should get create" do
    get cafes_create_url
    assert_response :success
  end

  test "should get edit" do
    get cafes_edit_url
    assert_response :success
  end

  test "should get update" do
    get cafes_update_url
    assert_response :success
  end

  test "should get delete" do
    get cafes_delete_url
    assert_response :success
  end

  test "should get global_cafes" do
    get cafes_global_cafes_url
    assert_response :success
  end

  test "should get my_cafes" do
    get cafes_my_cafes_url
    assert_response :success
  end

end
