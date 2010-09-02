require 'spec_helper'

describe WorkUnit do
  it "fails validation with no ticket_id" do
    WorkUnit.new.should have(1).errors_on(:ticket_id)
  end
end
