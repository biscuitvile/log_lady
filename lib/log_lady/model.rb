module LogLady
  module Model

    def self.included(base)
      base.extend ClassMethods
    end

    module ClassMethods
      def log_lady_sees
        self.class_eval do

          has_many :logs,
            class_name: '::LogLady::Log',
            as: :loggable

          before_create do
            logs.build
          end
        end
      end
    end

  end
end
