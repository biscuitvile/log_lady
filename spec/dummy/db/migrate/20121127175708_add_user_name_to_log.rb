class AddUserNameToLog < ActiveRecord::Migration
  def change
    add_column :log_lady_logs, :user_name, :string
  end
end
