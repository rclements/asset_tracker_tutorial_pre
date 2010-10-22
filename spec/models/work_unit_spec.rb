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

end
