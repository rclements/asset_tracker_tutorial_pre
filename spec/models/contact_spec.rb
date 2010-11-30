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
  
  describe 'for_client' do
    it 'should return the proper list of contacts for the client' do
      contact_1 = Contact.make
      client = contact_1.client
      contact_2 = Contact.make
      Contact.for_client(client).include?(contact_1).should be_true
      Contact.for_client(client).include?(contact_2).should be_false
    end
  end

  describe 'recieves_email' do
    it 'should return the proper list of contacts that can recieve email' do
      contact_1 = Contact.make(:recieves_email => true)
      client = contact_1.client
      contact_2 = Contact.make
      Contact.for_client(client).recieves_email.include?(contact_1).should be_true
      Contact.for_client(client).recieves_email.include?(contact_2).should_not be_true
    end
  end
end
