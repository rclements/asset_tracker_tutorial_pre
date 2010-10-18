Feature: Non-admin Authorization
  As a non-admin user
  I should have role-specific priveleges

  Scenario: List users (non-admin role)
    Given I am an authenticated user
    When I go to the admin users page
    Then I should be on the home page
    And I should see "You must be an admin to do that." within "#flash_error"

  Scenario: Create users (non-admin role)
    # Given I am an authenticated user
    # When I go to the "New User" page
    # Then I should be on the home page

  Scenario: Edit users (non-admin role)
    # Given I am an authenticated user

  Scenario: Destroy users (non-admin role)
