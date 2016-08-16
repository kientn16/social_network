class CreateFriends < ActiveRecord::Migration
  def change
    create_table :friends do |t|
      t.references :user, index: true, foreign_key: true
      t.integer :friend_user_id
      t.integer :is_friend
      t.integer :is_request_friend
      t.integer :is_favorite

      t.timestamps null: false
    end
  end
end
