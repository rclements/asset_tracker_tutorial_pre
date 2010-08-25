Feature: Manage projects
  In order to [goal]
  [stakeholder]
  wants [behaviour]

  Scenario: List projects
    Given the following projects:
      |name|
      |name 1|
      |name 2|
      |name 3|
      |name 4|
    When I visit the projects index page
    Then I should see the following projects:
      |Name|
      |name 1|
      |name 2|
      |name 3|
      |name 4|
    Then show me the page

  Scenario: Register new project
    Given I am on the new project page
    When I fill in "Name" with "name 1"
    And I press "Create"
    Then I should see "name 1"

  Scenario: Delete project
    Given the following projects:
      |name|
      |name 1|
      |name 2|
      |name 3|
      |name 4|
    When I delete the 3rd project
    Then I should see the following projects:
      |Name|
      |name 1|
      |name 2|
      |name 4|
