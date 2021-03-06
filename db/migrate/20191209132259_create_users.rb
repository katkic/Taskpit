class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :name, null: false, limit: 30
      t.string :email, null: false, limit: 255
      t.string :password_digest, null: false

      t.timestamps
    end
  end
end
