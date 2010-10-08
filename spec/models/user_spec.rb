require 'spec_helper'

describe User do
  let(:user) { User.new }
  subject{ user }

  it 'fails validation with no first name' do
    should have(1).errors_on(:first_name)
  end

  it 'fails validation with no last name' do
    should have(1).errors_on(:last_name)
  end

  it 'fails validation with no middle initial' do
    should have(1).errors_on(:middle_initial)
  end

  describe 'that has a name' do
    let(:user) { User.new(:first_name => 'Nick', :middle_initial => 'D', :last_name => 'Fine') }
    subject{ user.initials }

    it 'responds correctly to #initials' do
      should == 'NDF'
    end
  end

end
