class ChangeRaitingTypeInRaitings < ActiveRecord::Migration
  def change
    change_column :raitings, :raiting, :float
  end
end
