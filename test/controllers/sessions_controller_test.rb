require 'test_helper'

class SessionsControllerTest < ActionDispatch::IntegrationTest
  
  test "should prompt login" do
    get login_url
    assert_response :success
  end

  test "should login" do
    one_user = users(:one)
    post login_url, params: { name: one_user.name, password: '1234' }
    assert_redirected_to admin_url
    assert_equal one_user.id, session[:user_id]
  end

  test "should fail login" do
    one_user = users(:one)
    post login_url, params: { name: one_user.name, password: 'wrong' }
    assert_redirected_to login_url
  end

  test "should logout" do
    delete logout_url
    assert_redirected_to store_index_url
  end

end
