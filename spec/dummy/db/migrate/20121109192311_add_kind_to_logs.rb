class AddKindToLogs < ActiveRecord::Migration
  def change
    add_column :log_lady_logs, :kind, :string
  end
end
