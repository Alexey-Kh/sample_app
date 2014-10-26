require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest

  test "invalid signup information" do
    get signup_path
    assert_no_difference 'User.count' do
      post users_path, user: { name: "",
                               email: "invalidemail",
                               password: "foo",
                               password_confirmation: "bar" }
    end
    assert_template 'users/new'
    assert_select 'div.alert.alert-danger', "The form contains 4 errors."
    assert_select 'div#error_explanation' do
      assert_select 'ul' do
        assert_select "li", 4
      end
    end    
  end

  test "valid signup information" do
    get signup_path
    assert_difference 'User.count', 1 do
      post_via_redirect users_path, user: { name: "Example",
                                    email: "example@example.com",
                                    password: "foobar",
                                    password_confirmation: "foobar" }
    end
    assert_template 'users/show'
    assert_not flash.empty?
  end

end
