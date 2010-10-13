Given /^the following user records:$/ do |users|
  users.hashes.each do |user|
    the_role = user.delete("role")
    u = User.create(user)
    # add role
    u.has_role!(the_role.to_sym)
  end
end
