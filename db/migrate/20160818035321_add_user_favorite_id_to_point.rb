class AddUserFavoriteIdToPoint < ActiveRecord::Migration
  def change
    add_column :points, :favorite_user_id, :integer
  end
end
