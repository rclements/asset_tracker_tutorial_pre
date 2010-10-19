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
    Given I am an authenticated user with an "admin" role
    Given I am on the admin user's new page
    When I fill in "First name" with "name 1"
    And I fill in "Last name" with "man"
    And I fill in "Middle initial" with "m"
    And I fill in "Email" with "name1@example.com"
    And I fill in "Password" with "secretpass"
    And I fill in "Password confirmation" with "secretpass"
    And I press "Create"
    Then I should see "name 1"

  Scenario: Edit a user
    Given I am an authenticated user with an "admin" role
    Given a user exists with first_name: "Test", last_name: "Man", middle_initial: "T", email: "test@example.com", password: "secret", password_confirmation: "secret"
    When I go to the admin user's edit page
    Then I should see "First name"
    And I should see "Last name"
    And I should see "Middle initial"
    And I should see "Email"
    And I should see "Password"
    And I should see "Locked"

  Scenario: Destroy users (admin role)
    Given I am an authenticated user with an "admin" role
    Given the following user records:
     | first_name | last_name | middle_initial | email             | password | role |
     | Test 1     | Man       | T              | test1@example.com | secret   | user |
     | Test 2     | Man       | T              | test2@example.com | secret   | user |
     | Test 3     | Man       | T              | test3@example.com | secret   | user |
     | Test 4     | Man       | T              | test4@example.com | secret   | user |
    When I go to the admin users page
    When I delete the 3rd user
    Then I should see the following users:
      | Name       | Email             |
      | Nick Fine  | testing@man.net   |
      | Test 1 Man | test1@example.com |
      | Test 3 Man | test3@example.com |
      | Test 4 Man | test4@example.com |
