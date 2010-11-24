Feature: Project Assignment
  In order to manage projects properly
  Administrators should be able to assign projects to developers

  @wip
  Scenario: Assign a project to a developer
    Given I am an authenticated user with an "admin" role
    And a user exists with a "developer" role
    And a project exists
    When I assign that project to that user
    Then that user should have access to that project

  @wip
  Scenario: Check if the project is assigned to the user
    Given I am an authenticated user with an "admin" role
    And a user exists with a "developer" role
    And a project exists
    And that project is assigned to that user
    When I call "user.assigned_to?(:project)"
    Then it should return true
