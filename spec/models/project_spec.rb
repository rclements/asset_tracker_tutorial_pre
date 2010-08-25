require 'spec_helper'

describe Project do
  it "fails validation with no name" do
    Project.new.should have(1).errors_on(:name)
  end

  context "with an existing project with the same name on a given client" do
    before(:each) do
      @client = Client.create(:name => 'testee', :status => 'testee')
      @project = Project.create(:name => 'test', :client => @client)
    end

    it "requires unique names scoped by client" do
      p = Project.new(:name => 'test', :client => @client)
      p.valid?
      p.should have(1).errors_on(:name)
    end
  end
end
