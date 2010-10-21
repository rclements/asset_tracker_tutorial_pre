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
  
  
end
