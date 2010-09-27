require 'spec_helper'

describe WorkUnit do
  let(:work_unit) { WorkUnit.new }
  subject{ work_unit }
  
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
end
