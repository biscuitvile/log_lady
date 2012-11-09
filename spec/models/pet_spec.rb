require 'spec_helper'

describe Pet do
  let(:felix) { Pet.new(name: "Felix", kind: "Cat") }

  def first_change
    felix.logs.first
  end

  def last_change
    felix.logs.last
  end

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
      first_change.should be_persisted
    end

    it "tracks attributes changes in its log" do
      first_change.changeset
        .should == { 'name' => [nil, "Felix"], 'kind' => [nil, "Cat"] }
    end

    it "logs a create operation" do
      first_change.kind.should == 'create'
    end

  end

  context "after update" do
    before do
      felix.save; felix.update_attributes(name: 'Garfield')
    end

    it "should have two logs" do
      felix.logs.count.should == 2
      last_change.should be_persisted
    end

    it "tracks attributes changes in its log" do
      last_change.changeset
        .should == { 'name' => ["Felix", "Garfield"] }
    end

    it "logs an update operation" do
      last_change.kind.should == 'update'
    end
  end

  context "after destory" do
    before do
      felix.save; felix.destroy
    end

    it "should have two logs" do
      felix.logs.count.should == 2
      last_change.should be_persisted
    end

    it "tracks attributes changes in its log" do
      last_change.changeset
        .should == { 'name' => ["Felix", "Felix"], 'kind' => ["Cat", "Cat"] }
    end
  end
end
