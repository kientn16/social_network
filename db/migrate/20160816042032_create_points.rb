class CreatePoints < ActiveRecord::Migration
  def change
    create_table :points do |t|
      t.references :user, index: true, foreign_key: true
      t.integer :point

      t.timestamps null: false
    end
  end
end
