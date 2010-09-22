require 'spec_helper'

describe Client do
  let(:client) { Client.new }
  subject{ client }

  it "fails validation with no name" do
    should have(1).errors_on(:name)
  end

  it "fails validation with no status" do
    should have(1).errors_on(:status)
  end

  describe "with an existing client with the same name" do
    before(:each) do
      Client.create(:name => "test", :status => "Good")
    end

    let(:client_dup) { Client.create(:name => "test", :status => "Good") }

    subject{ client_dup }
    it "fails validation with error on name" do
      should have(1).errors_on(:name)
    end
  end
end
