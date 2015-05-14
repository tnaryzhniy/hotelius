class AddUserRefToHotels < ActiveRecord::Migration
  def change
    add_reference :hotels, :user, index: true
    add_foreign_key :hotels, :users
  end
end
