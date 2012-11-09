module LogLady
  class Writer

    def before_create(record)
      record.log_change({
        changeset: build_changeset(record, :changed_attributes),
        kind: 'create'
      })
    end

    alias :before_update :before_create

    def before_destroy(record)
      record.logs.create changeset: build_changeset(record, :predestroy_attributes)
    end

    def build_changeset(record, changes_message)
      changes = record.public_send(changes_message)
      changes.inject({}) do | result, (attr, old_val) |
        result[attr] = [ old_val, record.send(attr) ]; result
      end
    end
  end
end
