class AddHeightToUsers < ActiveRecord::Migration[8.0]
  def change
    add_column :users, :height, :integer
  end
end
