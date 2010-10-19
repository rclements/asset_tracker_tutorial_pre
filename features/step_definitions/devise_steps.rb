Given /^I have one\s+user "([^\"]*)" with password "([^\"]*)" and login "([^\"]*)"$/ do |email, password, login|
  User.create!(:email => email,
               :login => login,
               :password => password,
               :first_name => 'Nick',
               :last_name => 'Fine',
               :middle_initial => 'D',
               :password_confirmation => password)
end


Given /^I am an authenticated user$/ do
  email = 'testing@man.net'
  login = 'Testing man'
  password = 'secretpass'

  Given %{I have one user "#{email}" with password "#{password}" and login "#{login}"}
  visit('/users/sign_in')
#  And %{I go to login}
  And %{I fill in "user_email" with "#{email}"}
  And %{I fill in "user_password" with "#{password}"}
  And %{I press "Sign in"}
end
