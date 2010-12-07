require 'spec_helper'

describe WorkUnit do
  let(:work_unit) { WorkUnit.new }
  subject{ work_unit }

  it 'belongs to a ticket' do
    should belong_to(:ticket)
  end

  it 'belongs to a user' do
    should belong_to(:user)
  end

  it 'fails validation with no ticket_id' do
    should have(1).errors_on(:ticket_id)
  end

  it 'fails validation with no user' do
    should have(1).errors_on(:user_id)
  end

  it 'fails validation with no description' do
    should have(1).errors_on(:description)
  end

  it 'fails validation with no scheduled_at' do
    should have(1).errors_on(:scheduled_at)
  end

  it 'fails validation with no hours' do
    should have(1).errors_on(:hours)
  end

  it "allows comments" do
    subject.respond_to?(:comments).should be true
  end

  describe 'for_client' do
    it 'should return the proper work units for a given client' do
      work_unit_1 = WorkUnit.make
      ticket = work_unit_1.ticket
      client = work_unit_1.client
      work_unit_2 = WorkUnit.make(:ticket => ticket)
      work_unit_3 = WorkUnit.make
      WorkUnit.for_client(client).should == [work_unit_1, work_unit_2]
      WorkUnit.for_client(client).include?(work_unit_3).should_not == true
    end
  end

  describe 'email_list' do
    it 'should return the proper list of contacts email_addresses for a given work unit' do
      work_unit_1 = WorkUnit.make
      ticket = work_unit_1.ticket
      work_unit_2 = WorkUnit.make(:ticket => ticket)
      client = work_unit_1.client
      contact_1 = Contact.make(:receives_email => true, :client => client)
      contact_2 = Contact.make(:receives_email => true, :client => client)
      contact_3 = Contact.make(:receives_email => false, :client => client)
      work_unit_3 = WorkUnit.make
      proper_list = [contact_1.email_address, contact_2.email_address]
      work_unit_1.email_list.should == proper_list
    end
  end

  describe 'while being created' do
    it 'should create a new work unit from the blueprint' do
      lambda do
        WorkUnit.make
      end.should change(WorkUnit, :count).by(1)
    end
  end

  describe '.client' do
    it 'returns the parent client of that work unit' do
      workunit = WorkUnit.make
      workunit.client.should == workunit.ticket.project.client
    end
  end

  describe '.project' do
    it 'returns the parent project of that work unit' do
      workunit = WorkUnit.make
      workunit.project.should == workunit.ticket.project
    end
  end

  describe '.paid?' do
    it 'returns true if the work unit has been paid' do
      workunit = WorkUnit.new
      workunit.paid = 'Check 1000'
      workunit.paid?.should == true
    end
  end

  describe '.unpaid?' do
    it 'returns true if the work unit has NOT been paid' do
      workunit = WorkUnit.new
      workunit.paid = ''
      workunit.unpaid?.should == true
    end
  end

  describe '.invoiced?' do
    it 'returns true if the work unit has been invoiced' do
      workunit = WorkUnit.new
      workunit.invoiced = 'Invoice 1000'
      workunit.invoiced?.should == true
    end
  end

  describe '.not_invoiced?' do
    it 'returns true if the work unit has NOT been invoiced' do
      workunit = WorkUnit.new
      workunit.invoiced = ''
      workunit.not_invoiced?.should == true
    end
  end

  describe '.to_s' do
    it 'returns the description' do
      workunit = WorkUnit.new
      workunit.description = 'testing'
      workunit.to_s.should == 'testing'
    end
  end

  describe '.allows_access?' do
    before(:each) do
      @user = User.make
      @work_unit = WorkUnit.make
      @project = @work_unit.project
    end

    it 'returns false if the user does not have access to the parent client' do
      @work_unit.allows_access?(@user).should be_false
    end

    it 'returns true if the user has access to the parent client' do
      @user.has_role!(:developer, @project)
      @work_unit.allows_access?(@user).should be_true
    end
  end
end
