class AddChangesetToLogLadyLogs < ActiveRecord::Migration
  def change
    add_column :log_lady_logs, :changeset, :text
  end
end
