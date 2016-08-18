require 'rails_helper'

RSpec.describe User, type: :model do
  describe "db schema" do
    context "columns" do
      it { should have_db_column(:email).of_type(:string) }
      it { should have_db_column(:name).of_type(:string) }
      it { should have_db_column(:password).of_type(:string) }
      it { should have_db_column(:address).of_type(:string) }
      it { should have_db_column(:phone).of_type(:string) }
      it { should have_db_column(:image).of_type(:string) }
    end
  end

  describe "Validations" do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:password) }
    it { should validate_presence_of(:address) }
    it { should validate_presence_of(:phone) }
    it { should validate_uniqueness_of(:email) }
  end
  # relationship
  describe "associations" do
    it { should have_many (:friends) }
  end


#   rspec function search
  describe ".search(params)" do
    context "search" do
      # kientn = FactoryGirl.create(:user, name: "Kien", email: "kientn@gmail.com", address: "Sai son - ha noi", password: "Trankien1691", image: File.new(Rails.root + 'spec/fixtures/images/rails.png'))
      kientn = FactoryGirl.create(:user)
      params = { key_word: "gmail.com", sort: "name", order: "asc" }
      user = User.search(params) || {}
      expect(user).to eq nil
    end
  end



end
