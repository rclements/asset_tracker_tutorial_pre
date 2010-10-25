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
end
