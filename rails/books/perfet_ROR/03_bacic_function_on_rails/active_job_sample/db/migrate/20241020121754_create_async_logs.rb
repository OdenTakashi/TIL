class CreateAsyncLogs < ActiveRecord::Migration[7.2]
  def change
    create_table :async_logs do |t|
      t.string :message

      t.timestamps
    end
  end
end
