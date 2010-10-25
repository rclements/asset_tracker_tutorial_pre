require 'spec_helper'

describe Ticket do
  let(:ticket){ Ticket.new }
  subject{ ticket }

  it "should allow comments" do
    subject.respond_to?(:comments).should be true
  end

  context 'validations' do
    it "fails validation with no project_id" do
      should have(1).errors_on(:project_id)
    end

    it "fails validation with no name" do
      should have(1).errors_on(:name)
    end
  end

  context 'when dealing with associations' do
    it "should belong to a project" do
      should belong_to(:project)
    end

    it "should have many work units" do
      should have_many(:work_units)
    end
  end

  describe 'while being created' do
    it 'should create a new ticket from the blueprint' do
      lambda do
        Ticket.make
      end.should change(Ticket, :count).by(1)
    end
  end

  describe '.client' do
    context 'when a ticket exists' do
      it 'returns the client' do
        ticket = Ticket.make
        ticket.client.should == ticket.project.client
      end
    end
  end

  describe '.sum_of_hours_unpaid' do
    context 'when there are unpaid work units on a ticket' do
      it 'totals the unpaid hours for that ticket' do
        ticket = Ticket.make
        work_unit_1 = WorkUnit.make(:ticket => ticket)
        work_unit_2 = WorkUnit.make(:ticket => ticket)
        work_unit_3 = WorkUnit.make(
          :ticket => ticket,
          :paid => 'paid on 2010-10-25')
        unpaid_hours = work_unit_1.hours + work_unit_2.hours
        ticket.sum_of_hours_unpaid.should == unpaid_hours
      end
    end
  end

  describe '.sum_of_hours_not_invoiced' do
    context 'when there are uninvoiced work units on a ticket' do
      it 'returns the total number of uninvoiced work units for that ticket' do
        ticket = Ticket.make
        work_unit_1 = WorkUnit.make(:ticket => ticket)
        work_unit_2 = WorkUnit.make(:ticket => ticket)
        work_unit_3 = WorkUnit.make(
          :ticket => ticket,
          :invoiced => 'invoiced on 2010-10-25' )
        uninvoiced_hours = work_unit_1.hours + work_unit_2.hours
        ticket.sum_of_hours_not_invoiced.should == uninvoiced_hours
      end
    end
  end

  describe '.to_s' do
    it 'returns the name of the ticket as a string' do
      ticket = Ticket.make(:name => 'Testticket')
      ticket.to_s.should == 'Testticket'
    end
  end

  describe '.long_name' do
    it 'returns a descriptive string with the ticket id, project, and client' do
      ticket = Ticket.make
      id = ticket.id
      project_name = ticket.project.name
      client_name = ticket.project.client.name
      long_name = "Ticket: [#{id}] - #{project_name} Ticket for #{client_name}"
      ticket.long_name
    end
  end

end
