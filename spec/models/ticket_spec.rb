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

end
