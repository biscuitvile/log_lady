require 'spec_helper'

describe Pet do
  let(:felix) { Pet.new(name: "Felix", kind: "Cat") }

  context "before create" do
    it "logs are empty" do
      felix.logs.should be_empty
    end
  end

  context "after create" do
    it "should have one log" do
      felix.save
      felix.logs.count.should == 1
      felix.logs.first.should be_persisted
    end
  end
end
