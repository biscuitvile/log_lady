module LogLady
  class Writer
    attr_accessor :record

    def before_create(record)
      self.record = record
      record.logs.build changeset: _build_changeset(record.changed_attributes)
    end

    alias :before_update :before_create

    def before_destroy(record)
      self.record = record
      record.logs.create changeset: _build_changeset(record.predestroy_attributes)
    end

    def _build_changeset(changes)
      changes.inject({}) do | result, (attr, old_val) |
        result[attr] = [ old_val, record.send(attr) ]; result
      end
    end
  end
end
