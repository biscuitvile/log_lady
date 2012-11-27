require 'log_lady/writer'

module LogLady
  describe Writer do

    def self.it_uses(attribute_set)
      it "uses #{attribute_set}" do
        attributes = { food: 'seitan' }
        record.stub(food: 'pizza')
        record.stub(attribute_set) { attributes }
        record.should_receive(:log_change).with hash_including(
          { changeset: { food: [ 'seitan', 'pizza' ] } }
        )
        do_it
      end
    end

    def self.it_tracks_user_name
      it "sets the current user name" do
        Thread.current[:log_lady_user_name] = 'Bob'
        record.should_receive(:log_change).with hash_including(user_name: 'Bob')
        do_it
      end
    end

    let(:writer) { Writer.new }
    let(:record) { double.as_null_object }

    describe "#before_create" do

      def do_it
        writer.before_create(record)
      end

      it "sets kind to create" do
        record.should_receive(:log_change).with hash_including(kind: 'create')
        do_it
      end

      it_tracks_user_name
      it_uses(:changed_attributes)

    end

    describe "#before_update" do
      def do_it
        writer.before_update(record)
      end

      it "sets kind to update" do
        record.should_receive(:log_change).with hash_including(kind: 'update')
        do_it
      end

      it_tracks_user_name
      it_uses(:changed_attributes)

    end

    describe "#before_destroy" do
      def do_it
        writer.before_destroy(record)
      end

      it "sets kind to destroy" do
        record.should_receive(:log_change).with hash_including(kind: 'destroy')
        do_it
      end

      it_tracks_user_name
      it_uses(:predestroy_attributes)

    end
  end

end
