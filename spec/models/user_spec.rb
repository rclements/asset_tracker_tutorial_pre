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

      it "should have a with_unpaid_work_units method" do
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

  describe '.initials' do
    it "returns the user's initials" do
      user = User.make(:first_name => 'John', :middle_initial => 'W', :last_name => 'Smith')
      initials = 'JWS'
      user.initials.should == initials
    end
  end

  describe '.to_s' do
    it "returns the user's full name" do
      user = User.make(:first_name => 'John', :middle_initial => 'W', :last_name => 'Smith')
      full_name = 'John W Smith'
      user.to_s.should == full_name
    end
  end

  describe '.admin?' do
    it 'returns true if the user is an admin' do
      user = User.make
      user.has_role!(:admin)
      user.admin?.should == true
    end
  end

  describe '.locked' do
    it 'returns true if the user is locked' do
      user = User.make
      user.lock_access!
      user.locked.should == true
    end
  end

  describe '.work_units_for_day' do
    it 'lists work units that are scheduled for a specified day' do
      user = User.make
      work_unit_1 = WorkUnit.make(:user => user)
      work_unit_2 = WorkUnit.make(:user => user)
      work_unit_3 = WorkUnit.make(:user => user, :scheduled_at => 3.days.ago)
      user.work_units_for_day(Time.zone.now).should == [work_unit_1, work_unit_2]
    end
  end

  describe '.work_units_for_week' do
    it 'lists work units that are scheduled for a specified day' do
      user = User.make
      work_unit_1 = WorkUnit.make(:user => user)
      work_unit_2 = WorkUnit.make(:user => user)
      work_unit_3 = WorkUnit.make(:user => user, :scheduled_at => 9.days.ago)
      user.work_units_for_week(Time.zone.now).should == [work_unit_1, work_unit_2]
    end
  end

  describe '.clients_for_day' do
    it 'lists clients for work units that are scheduled for a specified day' do
      user = User.make
      work_unit_1 = WorkUnit.make(:user => user)
      work_unit_2 = WorkUnit.make(:user => user)
      work_unit_3 = WorkUnit.make(:user => user, :scheduled_at => 3.days.ago)
      user.clients_for_day(Time.zone.now).should == [work_unit_1, work_unit_2].map(&:client)
    end
  end

  describe '.unpaid_work_units' do
    it 'lists work units for this user that have not been paid' do
      user = User.make
      work_unit_1 = WorkUnit.make(:user => user)
      work_unit_2 = WorkUnit.make(:user => user)
      work_unit_3 = WorkUnit.make(:user => user, :paid => '111')
      user.unpaid_work_units.should == [work_unit_1, work_unit_2]
    end
  end

  it 'methods should still work with other time zones'
end
