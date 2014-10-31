require 'test_helper'

class UsersShowTest < ActionDispatch::IntegrationTest

  def setup
    @non_admin = users(:petya)
    @non_activated = users(:non_activated)
  end

  test "show with non-activated user" do
    get user_path(@non_activated)
    assert_response :redirect
    follow_redirect!
    assert_template 'static_pages/home'
  end

end
