module LogLady
  class Writer

    def before_create(record)
      record.log_change({
        changeset: build_changeset(record, :changed_attributes),
        kind: 'create',
        user_name: Thread.current[:log_lady_user_name]
      })
    end

    def before_update(record)
      record.log_change({
        changeset: build_changeset(record, :changed_attributes),
        kind: 'update',
        user_name: Thread.current[:log_lady_user_name]
      })
    end

    def before_destroy(record)
      record.log_change({
        changeset: build_changeset(record, :predestroy_attributes),
        kind: 'destroy',
        user_name: Thread.current[:log_lady_user_name]
      })
    end

    def build_changeset(record, changes_message)
      changes = record.public_send(changes_message)
      changes.inject({}) do | result, (attr, old_val) |
        result[attr] = [ old_val, record.send(attr) ]; result
      end
    end
  end
end
