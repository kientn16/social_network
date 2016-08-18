class RemoveFavoriteUserIdToPoints < ActiveRecord::Migration
  def change
    remove_column :points, :favorite_user_id, :integer
  end
end
