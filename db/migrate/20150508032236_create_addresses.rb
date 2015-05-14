class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.string :country
      t.string :state
      t.string :city
      t.string :street
      t.references :hotel, index: true

      t.timestamps null: false
    end
    add_foreign_key :addresses, :hotels
  end
end
