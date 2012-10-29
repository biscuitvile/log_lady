class Pet < ActiveRecord::Base
  attr_accessible :kind, :name
  log_lady_sees
end
