require 'spec_helper'

describe Pet do
  let(:felix) { Pet.new(name: "Felix", kind: "Cat") }

  context "before create" do
    it "logs are empty" do
      felix.logs.should be_empty
    end
  end

  context "after create" do
    before do
      felix.save
    end

    it "should have one log" do
      felix.logs.count.should == 1
      felix.logs.first.should be_persisted
    end

    it "tracks attributes changes in its log" do
      felix.logs.first.changeset
        .should == { 'name' => [nil, "Felix"], 'kind' => [nil, "Cat"] }
    end
  end

  context "after update" do
    before do
      felix.save; felix.update_attributes(name: 'Garfield')
    end

    it "should have two logs" do
      felix.logs.count.should == 2
      felix.logs.last.should be_persisted
    end

    it "tracks attributes changes in its log" do
      felix.logs.last.changeset
        .should == { 'name' => ["Felix", "Garfield"] }
    end
  end
end
