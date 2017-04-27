require 'test_helper'

class SadCatsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get sad_cats_index_url
    assert_response :success
  end

  test "should get new" do
    get sad_cats_new_url
    assert_response :success
  end
end
