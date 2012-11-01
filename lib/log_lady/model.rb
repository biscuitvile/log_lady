module LogLady
  module Model

    def self.included(base)
      base.extend ClassMethods
    end

    def build_log
      logs.build(changeset: changes)
    end

    def build_destroy_log
      logs.create(changeset: predestroy_changes)
    end

    def predestroy_attributes
      attributes.delete_if { |key, val| ignore_attrs.include?(key) }
    end

    def predestroy_changes
      predestroy_attributes.inject({}) do | result, (attr, old_val) |
        result[attr] = [ old_val, self.send(attr) ]; result
      end
    end

    def ignore_attrs
      ["id", "created_at", "updated_at"]
    end

    def changes
      changed_attributes.inject({}) do | result, (attr, old_val) |
        result[attr] = [ old_val, self.send(attr) ]; result
      end
    end

    module ClassMethods
      def log_lady_sees
        self.class_eval do

          has_many :logs,
            class_name: '::LogLady::Log',
            as: :loggable

          before_create  :build_log
          before_update  :build_log
          before_destroy :build_destroy_log
        end
      end
    end
  end
end
