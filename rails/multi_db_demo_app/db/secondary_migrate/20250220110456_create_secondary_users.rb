class CreateSecondaryUsers < ActiveRecord::Migration[8.0]
  def change
    create_table :users do |t|
      t.integer :age
      t.timestamps
    end
  end
end
