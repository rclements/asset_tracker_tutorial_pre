require 'spec_helper'

describe WorkUnit do
  it "fails validation with no ticket_id" do
    WorkUnit.new.should have(1).errors_on(:ticket_id)
  end

  it "fails validation with no description" do
    WorkUnit.new.should have(1).errors_on(:description)
  end

  it "fails validation with no scheduled_at" do
    WorkUnit.new.should have(1).errors_on(:scheduled_at)
  end

  it "fails validation with no hours" do
    WorkUnit.new.should have(1).errors_on(:hours)
  end
end
