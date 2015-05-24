class ChangeRaitingTypeInRaitingsToInteger < ActiveRecord::Migration
  def change
    change_column :raitings, :raiting, :integer
  end
end
