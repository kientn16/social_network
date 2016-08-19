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
    before :each do
      @alex = FactoryGirl.create(:user, name: "Alex", email: "alex@gmail.com", address: "Sai son - ha noi", password: "Trankien1691", image: File.new(Rails.root + 'spec/fixtures/images/rails.png'))
      @kien = FactoryGirl.create(:user, name: "Kien", email: "kien@gmail.com", address: "Sai son - ha noi", password: "Trankien1691", image: File.new(Rails.root + 'spec/fixtures/images/rails.png'))
      @khanh = FactoryGirl.create(:user, name: "Khanh", email: "kien123@gmail.com", address: "Sai son - ha noi", password: "Trankien1691", image: File.new(Rails.root + 'spec/fixtures/images/rails.png'))

      FactoryGirl.create(:friend, user_id: @alex.id, friend_user_id: @kien.id, is_friend: 1)
      FactoryGirl.create(:friend, user_id: @kien.id, friend_user_id: @alex.id, is_friend: 1)
      FactoryGirl.create(:friend, user_id: @kien.id, friend_user_id: @khanh.id, is_friend: 1)
      FactoryGirl.create(:friend, user_id: @khanh.id, friend_user_id: @kien.id, is_friend: 1)

      FactoryGirl.create(:point, user_id: @kien.id, point: 5)
      FactoryGirl.create(:point, user_id: @khanh.id, point: 4)
    end

    # search name
    context "with matching letters sort: name, order: asc" do
      it "search home page params key_word: K, sort: name, order: asc" do
        params = { key_word: "K", sort: "name", order: "asc" }
        user = User.search(params) || {}
        expect(user).to eq [@khanh,@kien]
      end
    end

    context "with non-matching letters, sort: name, order: asc" do
      it "not match with params key_word: K, sort: name, order: asc" do
        params = { key_word: "K", sort: "name", order: "asc" }
        user = User.search(params) || {}
        expect(user).not_to include @alex
      end
    end

  #   Search order created_at
    context "with matching letters, sort: created, order: asc" do
      it "search home page params key_word: K, sort: created, order: asc" do
        # kientn = FactoryGirl.create(:user)
        params = { key_word: "gmail.com", sort: "created_at", order: "asc" }
        user = User.search(params) || {}
        expect(user).to eq [@alex,@kien,@khanh]
      end
    end

    context "with matching letters,sort: created, order: desc" do
      it "not match with params key_word: K, sort: created, order: desc" do
        # kientn = FactoryGirl.create(:user)
        params = { key_word: "gmail.com", sort: "created_at", order: "desc" }
        user = User.search(params) || {}
        expect(user).to eq [@alex,@kien,@khanh]
      end
    end

  # Search order friends
    context "with matching letters,sort: friends, order: desc" do
      it "search home page params key_word: gmail.com, sort: friends, order: desc" do
        # kientn = FactoryGirl.create(:user)
        params = { key_word: "gmail.com", sort: "friends", order: "desc" }
        user = User.search(params) || {}
        expect(user).to eq [@kien,@alex,@khanh]
      end
    end

    context "with matching letters,sort: friends, order: asc" do
      it "search home page params key_word: gmail.com, sort: friends, order: asc" do
        # kientn = FactoryGirl.create(:user)
        params = { key_word: "gmail.com", sort: "friends", order: "asc" }
        user = User.search(params) || {}
        expect(user).to eq [@alex,@khanh,@kien]
      end
    end


    context "with matching letters,sort: favorites, order: desc" do
      it "search home page params key_word: gmail.com, sort: favorites, order: desc" do
        # kientn = FactoryGirl.create(:user)
        params = { key_word: "gmail.com", sort: "favorites", order: "desc" }
        user = User.search(params) || {}
        expect(user).to eq [@kien,@khanh,@alex]
      end
    end

    context "with matching letters,sort: favorites, order: asc" do
      it "search home page params key_word: gmail.com, sort: favorites, order: asc" do
        # kientn = FactoryGirl.create(:user)
        params = { key_word: "gmail.com", sort: "favorites", order: "asc" }
        user = User.search(params) || {}
        expect(user).to eq [@alex,@khanh,@kien]
      end
    end
  end



end
