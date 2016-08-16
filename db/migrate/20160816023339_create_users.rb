class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :password
      t.string :password_digest
      t.string :address
      t.string :phone
      t.string :image

      t.timestamps null: false
    end
  end
end
