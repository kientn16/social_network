require 'rails_helper'

RSpec.describe "users/index", type: :view do
  before(:each) do
    assign(:users, [
      User.create!(
        :name => "Name",
        :email => "Email",
        :password => "Password",
        :address => "Address",
        :phone => "Phone",
        :image => "Image"
      ),
      User.create!(
        :name => "Name",
        :email => "Email",
        :password => "Password",
        :address => "Address",
        :phone => "Phone",
        :image => "Image"
      )
    ])
  end

  it "renders a list of users" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "Email".to_s, :count => 2
    assert_select "tr>td", :text => "Password".to_s, :count => 2
    assert_select "tr>td", :text => "Address".to_s, :count => 2
    assert_select "tr>td", :text => "Phone".to_s, :count => 2
    assert_select "tr>td", :text => "Image".to_s, :count => 2
  end
end
