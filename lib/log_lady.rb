require 'log_lady/version'
require 'log_lady/model'
require 'log_lady/log'

module LogLady
end

ActiveSupport.on_load(:active_record) { include LogLady::Model }
