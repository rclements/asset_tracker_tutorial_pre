require 'spec_helper'

describe Ticket do
  it "fails validation with no project_id" do
    Ticket.new.should have(1).errors_on(:project_id)
  end

  it "fails validation with no name" do
    Ticket.new.should have(1).errors_on(:name)
  end
end
