class CreateRaitings < ActiveRecord::Migration
  def change
    create_table :raitings do |t|
      t.integer :raiting
      t.text :comment
      t.references :hotel, index: true
      t.references :user, index: true

      t.timestamps null: false
    end
    add_foreign_key :raitings, :hotels
    add_foreign_key :raitings, :users
  end
end
