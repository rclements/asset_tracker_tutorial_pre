Given /^the following user records:$/ do |users|
  users.hashes.each do |user|
    the_role = user.delete("role")
    u = User.create(user)
    # add role
    u.has_role!(the_role.to_sym)
  end
end

Then /^I should see the user's name$/ do
  pending #
end

Then /^I should see the user's email$/ do
  pending # express the regexp above with the code you wish you had
end

Then /^I should see the text field with label "([^"]*)"$/ do |arg1|
  pending # express the regexp above with the code you wish you had
end

Then /^I should see the text field "([^"]*)"$/ do |arg1|
  pending # express the regexp above with the code you wish you had
end

Then /^I should see the checkmark box "([^"]*)"$/ do |arg1|
  pending # express the regexp above with the code you wish you had
end

Given /^the following users:$/ do |table|
  # table is a Cucumber::Ast::Table
  pending # express the regexp above with the code you wish you had
end

When /^I delete the (\d+)rd user$/ do |arg1|
  pending # express the regexp above with the code you wish you had
end

