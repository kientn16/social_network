FactoryGirl.define do
  factory :friend do
    user nil
    friend_user_id 1
    is_friend 1
    is_request_friend 1
    is_favorite 1
  end
end
