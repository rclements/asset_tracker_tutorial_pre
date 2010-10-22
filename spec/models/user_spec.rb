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

  it 'should have many work units' do
    should have_many(:work_units)
  end

  describe 'that has a name' do
    let(:user) { User.new(:first_name => 'Nick', :middle_initial => 'D', :last_name => 'Fine') }
    subject{ user.initials }

    it 'responds correctly to #initials' do
      should == 'NDF'
    end
  end

  describe 'while being created' do    
    it 'should create a new user from the blueprint' do
      lambda do
        User.make
      end.should change(User, :count).by(1)
    
    end
  end
  

  context 'when dealing with scopes' do
    context 'and using the with_unpaid_work_units method' do
      before :each do 
        @user = User.make
        @work_unit = WorkUnit.make(:user => @user)
      end

      it "should have a prev_working_day method" do
        User.respond_to?(:with_unpaid_work_units).should be true
      end

      it "should not return a user that has no work units" do
        lazy_user = User.make
        User.with_unpaid_work_units.include?(lazy_user).should be false
      end

      it "should return a user that has an unpaid work unit" do
        User.with_unpaid_work_units.include?(@user).should be true
      end

      it "should not return a user that has all paid work units" do
        @work_unit.update_attribute(:paid, 'Check 1001')
        User.with_unpaid_work_units.include?(@user).should be false
      end
      
      it 'should only list a given user one time, regardless of how many unpaid work units they have' do
        WorkUnit.make(:user => @user)
        User.with_unpaid_work_units.to_a.count(@user).should == 1
      end
      
    end
  end

end
