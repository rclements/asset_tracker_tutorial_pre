require 'spec_helper'

describe Ticket do
  let(:ticket){ Ticket.new }
  subject{ ticket }

  it "should allow comments" do
    subject.respond_to?(:comments).should be true
  end

  it "fails validation with no project_id" do
    should have(1).errors_on(:project_id)
  end

  it "fails validation with no name" do
    should have(1).errors_on(:name)
  end
end
