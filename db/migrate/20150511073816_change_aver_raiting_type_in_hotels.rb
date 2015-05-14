class ChangeAverRaitingTypeInHotels < ActiveRecord::Migration
  def change
    change_column :hotels, :aver_raiting, :float
  end
end
