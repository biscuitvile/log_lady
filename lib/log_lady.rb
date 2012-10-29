require 'log_lady/version'
require 'log_lady/model'

module LogLady
end

ActiveSupport.on_load(:active_record) { include LogLady::Model }
