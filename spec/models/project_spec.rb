require 'spec_helper'

describe Project do
  let(:bad_project){ Project.new }

  it "fails validation with no name" do
    should have(1).errors_on(:name)
  end

  context "with an existing project with the same name on a given client" do
    let(:client)          { Client.create( :name => 'testee', :status => 'Good')}

    before(:each) do
      Project.create(:name => 'test',   :client => client)
      @project =  Project.new(:name => 'test',   :client => client)
    end

    subject{ @project }

    it "requires unique names scoped by client" do
      should have(1).errors_on(:name)
    end
  end
end
