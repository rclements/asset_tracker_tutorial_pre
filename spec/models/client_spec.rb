require 'spec_helper'

describe Client do
  it "fails validation with no name" do
    Client.new.should have(1).errors_on(:name)
  end

  it "fails validation with no status" do
    Client.new.should have(1).errors_on(:status)
  end

  it "requires unique names" do
    client = Client.create(:name => 'test', :status => 'test')
    Client.new(:name => 'test', :status => 'test').should have(1).errors_on(:name)
  end
end
