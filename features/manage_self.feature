Feature: Self administration
  As a user
  I should be able to change my password

  Scenario: Change password successfully
    Given I am an authenticated user "bobby@example.com" and password "changeme"
    When I go to the home page
    And I follow "Users"
    Then I should see "Change Password"
    When I fill in "Password" with "newpass"
    And I fill in "Password Confirmation" with "newpass"
    And I press "Update"
    Then I should see "Successfully updated password"

  Scenario: Change password failure
    Given I am an authenticated user "bobby@example.com" and password "changeme"
    When I go to the home page
    And I follow "Users"
    Then I should see "Change Password"
    When I fill in "Password" with "newpass"
    And I fill in "Password Confirmation" with "newpas"
    And I press "Update"
    Then I should see "Error changing password"


