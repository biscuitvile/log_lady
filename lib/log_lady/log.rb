module LogLady
  class Log < ActiveRecord::Base
    self.table_name = :log_lady_logs
    attr_accessible :changeset
    belongs_to :loggable, polymorphic: true
    serialize :changeset, Hash
  end
end
