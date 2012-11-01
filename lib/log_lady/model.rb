module LogLady
  module Model

    def self.included(base)
      base.extend ClassMethods
    end

    def build_log
      logs.build changeset: build_changeset(changed_attributes)
    end

    def build_destroy_log
      logs.create changeset: build_changeset(predestroy_attributes)
    end

    def predestroy_attributes
      attributes.except(*ignore_attrs)
    end

    def ignore_attrs
      ["id", "created_at", "updated_at"]
    end

    def build_changeset(changes)
      changes.inject({}) do | result, (attr, old_val) |
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
