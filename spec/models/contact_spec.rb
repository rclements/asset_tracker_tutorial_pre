require 'spec_helper'

describe Contact do
  let(:contact) { Contact.new }

  subject{ contact }
  
  it 'fails validation with no first_name' do
    should have(1).errors_on(:first_name)
  end

  it 'fails validation with no last_name' do
    should have(1).errors_on(:last_name)
  end

  it 'fails validation with no email_address' do
    should have(1).errors_on(:email_address)
  end
end
