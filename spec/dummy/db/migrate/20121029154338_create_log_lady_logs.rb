class CreateLogLadyLogs < ActiveRecord::Migration
  def change
    create_table :log_lady_logs do |t|
      t.string :loggable_type
      t.integer :loggable_id

      t.timestamps
    end
  end
end
