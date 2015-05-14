class AddCommenterToRaitings < ActiveRecord::Migration
  def change
    add_column :raitings, :commenter, :string
  end
end
