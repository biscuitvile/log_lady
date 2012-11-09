require 'log_lady/model'

module LogLady
  describe Model do

    let(:record) { Object.new.extend Model }
    let(:logs) { double }
    let(:attributes) { double }

    before do
      record.stub(:logs) { logs }
    end

    describe "#log_change" do
      context "upersisted record" do
        it "builds a log" do
          record.stub(persisted?: false)
          logs.should_receive(:build).with attributes
          record.log_change(attributes)
        end
      end
      context "persisted record" do
        it "creates a log" do
          record.stub(persisted?: true)
          logs.should_receive(:create).with attributes
          record.log_change(attributes)
        end
      end
    end
  end
end
