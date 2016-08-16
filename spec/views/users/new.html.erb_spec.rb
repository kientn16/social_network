require 'rails_helper'

RSpec.describe "users/new", type: :view do
  before(:each) do
    assign(:user, User.new(
      :name => "MyString",
      :email => "MyString",
      :password => "MyString",
      :address => "MyString",
      :phone => "MyString",
      :image => "MyString"
    ))
  end

  it "renders new user form" do
    render

    assert_select "form[action=?][method=?]", users_path, "post" do

      assert_select "input#user_name[name=?]", "user[name]"

      assert_select "input#user_email[name=?]", "user[email]"

      assert_select "input#user_password[name=?]", "user[password]"

      assert_select "input#user_address[name=?]", "user[address]"

      assert_select "input#user_phone[name=?]", "user[phone]"

      assert_select "input#user_image[name=?]", "user[image]"
    end
  end
end
