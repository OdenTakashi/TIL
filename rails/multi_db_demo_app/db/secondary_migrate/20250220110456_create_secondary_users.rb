class CreateSecondaryUsers < ActiveRecord::Migration[8.0]
  def change
    create_table :secondary_users do |t|
      t.timestamps
    end
  end
end
