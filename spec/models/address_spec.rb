require 'spec_helper'

describe Address do
  let(:address) { Address.new }

  subject{ address }
  
  it "fails validation with no address1" do
    should have(1).errors_on(:address1)
  end

  it "does not care about nil address2" do
    should_not have(1).errors_on(:address2)
  end

  it 'fails validation with no state' do
    should have(1).errors_on(:state)
  end

  it 'fails validation with no city' do
    should have(1).errors_on(:city)
  end

  it 'fails validation with no zipcode' do
    should have(1).errors_on(:zipcode)
  end
end
