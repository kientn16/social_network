class Friend < ActiveRecord::Base

  belongs_to :user, class_name: User, foreign_key: :user_id
  belongs_to :user_friend, class_name: User, foreign_key: :friend_user_id



end
