class AddColumnsForImageToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :x, :string
    add_column :users, :y, :string
    add_column :users, :width, :string
    add_column :users, :height, :string 
  end
end
