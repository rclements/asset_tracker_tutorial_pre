require 'spec_helper'

describe Client do

  it "should have many projects" do
    should have_many(:projects)
  end

  it "should have many tickets through projects" do
    should have_many(:tickets).through(:projects)
  end

  it "should validate presence of name" do
    should validate_presence_of(:name)
  end

  it "should validate presence of status" do
    should validate_presence_of(:status)
  end

  context 'when newly created' do
    let(:client) { Client.new }
    subject{ client }

    it "should allow comments" do
      subject.respond_to?(:comments).should be true
    end

    it "fails validation with no name" do
      should have(1).errors_on(:name)
    end

    it "fails validation with no status" do
      should have(1).errors_on(:status)
    end
  end

  context 'with an existing client with the same name' do
    before(:each) do
      Client.create(:name => "test", :status => "Good")
    end

    let(:client_dup) { Client.create(:name => "test", :status => "Good") }

    subject{ client_dup }
    it "fails validation with error on name" do
      should have(1).errors_on(:name)
    end
  end

  describe 'while being created' do
    it 'should create a new client from the blueprint' do
      lambda do
        Client.make
      end.should change(Client, :count).by(1)
    end
  end

  describe '.to_s' do
    it 'returns the client name as a string' do
      client = Client.make(:name => 'Testclient')
      client.to_s.should == 'Testclient'
    end
  end

  describe '.allows_access?' do
    before(:each) do
      @project = Project.make
      @client = @project.client
      @user = User.make
    end

    it 'returns false given a user that has no access to any of its projects' do
      @client.allows_access?(@user).should be_false
    end

    it 'returns true given a user has access to one or more of its projects' do
      @user.has_role!(:developer, @project)
      @client.allows_access?(@user).should be_true
    end
  end

  describe '.uninvoiced_hours' do
    it "returns the sum of hours on all the client's work units" do
      work_unit_1 = WorkUnit.make
      ticket = work_unit_1.ticket
      client = work_unit_1.client
      work_unit_2 = WorkUnit.make(:ticket => ticket)
      work_unit_3 = WorkUnit.make(:ticket => ticket, :invoiced => 'Invoiced', :invoiced_at => Time.current)
      total_hours = work_unit_1.hours + work_unit_2.hours
      client.uninvoiced_hours.should == total_hours
    end
  end
end
