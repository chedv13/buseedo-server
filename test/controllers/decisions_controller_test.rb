require 'test_helper'

class DecisionsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get decisions_index_url
    assert_response :success
  end

  test "should get show" do
    get decisions_show_url
    assert_response :success
  end

  test "should get create" do
    get decisions_create_url
    assert_response :success
  end

  test "should get update" do
    get decisions_update_url
    assert_response :success
  end

end
