module LogLady
  class Log < ActiveRecord::Base
    self.table_name = :log_lady_logs
    belongs_to :loggable, polymorphic: true
  end
end
