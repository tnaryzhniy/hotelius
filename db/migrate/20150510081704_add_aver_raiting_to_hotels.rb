class AddAverRaitingToHotels < ActiveRecord::Migration
  def change
    add_column :hotels, :aver_raiting, :integer
  end
end
