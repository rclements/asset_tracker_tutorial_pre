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

  describe '.hours' do
    it 'should return total number of hours from all tickets on the project' do
      project = Project.make
      ticket_1 = Ticket.make(:project => project)
      ticket_2 = Ticket.make(:project => project)
      WorkUnit.make(:ticket => ticket_1)
      WorkUnit.make(:ticket => ticket_2)
      project.hours.should == ticket_1.work_units.first.hours + ticket_2.work_units.first.hours
    end
  end

  describe '.uninvoiced_hours' do
    it "returns the sum of hours on all the client's work units" do
      work_unit_1 = WorkUnit.make
      ticket = work_unit_1.ticket
      project = work_unit_1.project
      work_unit_2 = WorkUnit.make(:ticket => ticket)
      work_unit_3 = WorkUnit.make(:ticket => ticket, :invoiced => 'Invoiced', :invoiced_at => Time.current)
      total_hours = work_unit_1.hours + work_unit_2.hours
      project.uninvoiced_hours.should == total_hours
    end
  end
end
