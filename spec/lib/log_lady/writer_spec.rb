require 'log_lady/writer'

module LogLady
  describe Writer do

    let(:writer) { Writer.new }
    let(:record) { double.as_null_object }

    describe "#before_create" do
      it "sets kind to create" do
        record.should_receive(:log_change).with hash_including(kind: 'create')
        writer.before_create(record)
      end
    end

  end
end
