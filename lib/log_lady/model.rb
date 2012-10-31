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

          before_create :build_log

          def build_log
            logs.build(changeset: changeset)
          end

          def changeset
            changed_attributes.inject({}) do | result, (attr, old_val) |
              result[attr] = [ old_val, self.send(attr) ]; result
            end
          end

        end
      end
    end
  end
end
