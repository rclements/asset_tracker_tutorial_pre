require 'spec_helper'

describe Project do
  let(:project){ Project.new }
  subject{ project }

  it "should allow comments" do
    subject.respond_to?(:comments).should be true
  end

  it "fails validation with no name" do
    should have(1).errors_on(:name)
  end

  it "should have many tickets" do
    should have_many(:tickets)
  end

  it "should belong to a client" do
    should belong_to(:client)
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

  describe 'while being created' do    
    it 'should create a new project from the blueprint' do
      lambda do
        Project.make
      end.should change(Project, :count).by(1)    
    end
  end

  describe '.to_s' do
    it 'returns the name of the project as a string' do
      project = Project.make(:name => 'Testproject')
      project.to_s.should == 'Testproject'
    end
  end
end
