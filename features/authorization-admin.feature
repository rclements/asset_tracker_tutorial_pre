Feature: Admin Authorization
  As an admin
  I should have role-specific priveleges

  Scenario: List users (admin role)
    Given I am an authenticated user with an "admin" role
    Given the following user records:
      | first_name | last_name | middle_initial | email             | password  | role  |
      | admin      | mcadmin   | a              | admin@example.com | secret    | admin |
    When I go to the admin users page
    Then I should see the following users:
      | Name          | Email             |
      | Nick Fine     | testing@man.net   |
      | admin mcadmin | admin@example.com |

  Scenario: Create users (admin role)
    # Given I am an authenticated user with an "admin" role
    # Given I am on the "New User" page
    # ...
    # When I fill in these fields: ...
    # And I click "Create"
    # Then I should see "Mister Testuser"

  Scenario: Edit users (admin role)
    # Given I am an authenticated user with an "admin" role
    # Given the following users table:
    # ...
    # Then I should see the following users table:

  Scenario: Destroy users (admin role)
    # Given I am an authenticated user with an "admin" role
    # ...
    # Then I should not see "Mister Testuser"
