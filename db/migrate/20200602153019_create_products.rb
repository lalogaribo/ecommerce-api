class CreateProducts < ActiveRecord::Migration[6.0]
  def change
    create_table :products do |t|
      t.string :name
      t.string :description
      t.belongs_to :type, null: false, foreign_key: true
      t.integer :quantity
      t.decimal :price
      t.integer :time_to_make
      t.string :image
      t.belongs_to :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
