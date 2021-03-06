require 'test_helper'

class SiteLayoutTest < ActionDispatch::IntegrationTest

  def setup
    @non_admin = users(:petya)
  end

  test "layout links as non-logged-in user" do
    get root_path
    assert_template 'static_pages/home'
    assert_select "a[href=?]", root_path, count: 2
    assert_select "a[href=?]", help_path
    assert_select "a[href=?]", login_path
    assert_select "a[href=?]", signup_path
    assert_select "a[href=?]", contact_path
    assert_select "a[href=?]", contact_path
    assert_select "a[href=?]", about_path
    assert_select "a[href=?]", contact_path
    get signup_path
    assert_select "title", full_title("Sign up")
  end

  test "layout links as logged-in user" do
    log_in_as(@non_admin)
    get root_path
    assert_template 'static_pages/home'
    assert_select "a[href=?]", root_path, count: 2
    assert_select "a[href=?]", help_path
    assert_select "a[href=?]", users_path
    assert_select "a[href=?]", user_path(@non_admin)
    assert_select "a[href=?]", edit_user_path(@non_admin)
    assert_select "a[href=?]", logout_path
    assert_select "a[href=?]", about_path
    assert_select "a[href=?]", contact_path
   end
  
end
