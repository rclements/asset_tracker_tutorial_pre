Given /^the following user records:$/ do |users|
  users.hashes.each do |user|
    the_role = user.delete("role")
    u = User.create(user)
    # add role
    u.has_role!(the_role.to_sym)
  end
end

When /^I delete the (\d+)(?:st|nd|rd|th) user$/ do |pos|
  visit admin_users_path
  within("table tbody tr:nth-child(#{pos.to_i})") do
    click_button "Destroy"
  end
end
