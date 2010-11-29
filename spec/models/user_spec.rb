require 'spec_helper'

describe User do

  let(:user) { User.new }

  describe 'before create' do

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

      before(:each) do
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

  describe 'that has a first, middle, and last name' do

    let(:user) { User.make(:first_name => 'John', :middle_initial => 'T', :last_name => 'Smith') }

    describe '.initials' do

      it "returns the user's initials" do
        user.initials.should == 'JTS'
      end

    end

    describe '.to_s' do

      it "returns the user's full name" do
        user.to_s.should == 'John T Smith'
      end

    end

    describe '.admin?' do

      it 'returns true if the user is an admin' do
        user.has_role!(:admin)
        user.admin?.should == true
      end

    end

    describe '.locked' do

      it 'returns true if the user is locked' do
        user.lock_access!
        user.locked.should == true
      end

      it 'returns false if the user is unlocked' do
        user.unlock_access!
        user.locked.should be_false
      end

    end

  end

  describe 'that has work units' do

    let(:user) { User.make }

    describe '.work_units_for_day' do

      it 'lists work units that are scheduled for a specified day' do
        work_unit_1 = WorkUnit.make(:user => user)
        work_unit_2 = WorkUnit.make(:user => user)
        work_unit_3 = WorkUnit.make(:user => user, :scheduled_at => 3.days.ago)
        user.work_units_for_day(Time.zone.now).should == [work_unit_1, work_unit_2]
      end

    end

    describe '.work_units_for_week' do

      it 'lists work units that are scheduled for a specified day' do
        work_unit_1 = WorkUnit.make(:user => user)
        work_unit_2 = WorkUnit.make(:user => user)
        work_unit_3 = WorkUnit.make(:user => user, :scheduled_at => 9.days.ago)
        user.work_units_for_week(Time.zone.now).should == [work_unit_1, work_unit_2]
      end

    end

    describe '.clients_for_day' do

      it 'lists clients for work units that are scheduled for a specified day' do
        work_unit_1 = WorkUnit.make(:user => user)
        work_unit_2 = WorkUnit.make(:user => user)
        work_unit_3 = WorkUnit.make(:user => user, :scheduled_at => 3.days.ago)
        user.clients_for_day(Time.zone.now).should == [work_unit_1, work_unit_2].map(&:client)
      end

    end

    describe '.unpaid_work_units' do

      it 'lists work units for this user that have not been paid' do
        work_unit_1 = WorkUnit.make(:user => user)
        work_unit_2 = WorkUnit.make(:user => user)
        work_unit_3 = WorkUnit.make(:user => user, :paid => '111')
        user.unpaid_work_units.should == [work_unit_1, work_unit_2]
      end

    end

  end

  describe '.assigned_projects' do
    it 'returns an array of all projects to which the user is assigned' do
      user = User.make
      project = Project.make(:name => 'Testproject')
      user.projects << project
      user.assigned_projects.include?(project).should be_true
    end
  end

  describe '.assigned_tickets' do
    it 'returns an array of all tickets to which the user is assigned' do
      user = User.make
      project = Project.make(:name => 'Testproject')
      ticket = Ticket.make(:project => project)
      user.projects << project
      user.assigned_tickets.include?(ticket).should be_true
    end
  end

  describe '.assigned_clients' do
    it 'returns an array of all clients to which the user is assigned' do
      user = User.make
      project = Project.make(:name => 'Testproject')
      user.projects << project
      user.assigned_clients.include?(project.client).should be_true
    end
  end

  it 'methods should still work with other time zones'
end
