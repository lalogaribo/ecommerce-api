class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.string :email, null: false
      t.index :email, unique: true
      t.string :phone_number
      t.boolean :is_admin, default: false
      t.string :address
      t.string :zip_code
      t.string :password_digest, null: false

      t.timestamps
    end
  end
end
