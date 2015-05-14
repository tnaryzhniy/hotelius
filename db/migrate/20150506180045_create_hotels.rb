class CreateHotels < ActiveRecord::Migration
  def change
    create_table :hotels do |t|
      t.string :title
      t.integer :stars
      t.boolean :breakfast
      t.text :rooms
      t.string :foto
      t.float :price

      t.timestamps null: false
    end
  end
end
