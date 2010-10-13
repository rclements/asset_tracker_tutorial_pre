Feature: User Administration
  As an admin
  I should be able to list users

  Scenario: List users (admin role)
    Given I am an authenticated user with an "admin" role
    Given the following user records:
      | first_name | last_name | middle_initial | email             | password  | role  |
      | admin      | mcadmin   | a              | admin@example.com | secret    | admin |
    When I am on the admin users index page
    Then I should see the following users:
      | Name          | Email             |
      | Nick Fine     | testing@man.net   |
      | admin mcadmin | admin@example.com |


  Scenario: List users (non-admin role)
    Given I am an authenticated user
    When I go to the admin users index page
    Then I should be on the home page
    And I should see "You must be an admin to do that." within "#flash_error"
