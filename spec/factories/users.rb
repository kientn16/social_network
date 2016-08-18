require 'faker'
FactoryGirl.define do
  factory :user do
    name Faker::Name.name
    email Faker::Internet.email
    password SecureRandom.hex(9)
    address Faker::Address.street_address
    phone Faker::PhoneNumber.cell_phone
    image File.new(Rails.root + 'spec/fixtures/images/rails.png')
  end
end
