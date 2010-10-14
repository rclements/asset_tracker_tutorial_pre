Feature: User Administration
  As an admin
  I should be able to manage users

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

  Scenario: View a user
    Given I am an authenticated user with an "admin" role
    Given the following user records:
      | first_name | last_name | middle_initial | email            | password | role |
      | Test       | Man       | T              | test@example.com | secret   | user |
    When I go to user's page
    Then show me the page
    Then I should see the user's name
    And I should see the user's email
    And I should see a link with text "Edit" within "#user .links"
    And I should see a link with text "Clients" within "#user .links"

  Scenario: Edit a user
    Then I should see the text field with label "First name"
    And I should see the text field with label "Last name"
    And I should see the text field with label "Middle initial"
    And I should see the text field with label ""
    And I should see the text field with label ""

  Scenario: Register new user
    Given I am an authenticated user with an "admin" role
    Given I am on the admin users new page
    When I fill in "First name" with "name 1"
    And I fill in "Last name" with "man"
    And I fill in "Middle initial" with "m"
    And I fill in "Email" with "name1@example.com"
    And I press "Create"
    Then I should see "name 1"

  Scenario: Register new user - the form
    Given I am an authenticated user
    Given I am on the new user page
    Then I should see a link with text "Cancel" within ".actions"

  Scenario: Delete user
    Given I am an authenticated user
    Given the following users:
      | first_name | last_name | middle_initial | email             | password | role |
      | Test 1     | Man       | T              | test1@example.com | secret   | user |
      | Test 2     | Man       | T              | test2@example.com | secret   | user |
      | Test 3     | Man       | T              | test3@example.com | secret   | user |
      | Test 4     | Man       | T              | test4@example.com | secret   | user |
    When I delete the 3rd user
    Then I should see the following users:
      | first_name | last_name | middle_initial | email             | password | role |
      | Test 1     | Man       | T              | test1@example.com | secret   | user |
      | Test 2     | Man       | T              | test2@example.com | secret   | user |
      | Test 4     | Man       | T              | test4@example.com | secret   | user |
