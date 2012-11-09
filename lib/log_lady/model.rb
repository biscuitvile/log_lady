module LogLady
  module Model

    def self.included(base)
      base.extend ClassMethods
    end

    def predestroy_attributes
      attributes.except(*ignore_attrs)
    end

    def ignore_attrs
      ["id", "created_at", "updated_at"]
    end

    def log_change(attributes)
      if persisted?
        logs.create(attributes)
      else
        logs.build(attributes)
      end
    end

    module ClassMethods
      def log_lady_sees
        self.class_eval do

          has_many :logs,
            class_name: '::LogLady::Log',
            as: :loggable

          before_create  Writer.new
          before_update  Writer.new
          before_destroy Writer.new
        end
      end
    end
  end
end
