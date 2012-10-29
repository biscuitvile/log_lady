require 'spec_helper'

describe Pet do
  context "before create" do
    it "logs are empty" do
      Pet.new.logs.should be_empty
    end
  end
end
