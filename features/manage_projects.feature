Feature: Manage projects
  In order to manage projects
  Visitor
  wants a nice management interface

  Scenario: List projects
    Given a client exists
    And a project exists with client: the first client and name: test project
    When I visit the projects index page for the first client
    Then I should see the following projects:
      |Name|
      |test project|
    Then show me the page

#  Scenario: Register new project
#    Given I visit the new project page for a given client
#    When I fill in "Name" with "name 1"
#    And I press "Create"
#    Then I should see "name 1"
#
#  Scenario: Delete project
#    Given the following projects:
#      |name|
#      |name 1|
#      |name 2|
#      |name 3|
#      |name 4|
#    When I delete the 3rd project
#    Then I should see the following projects:
#      |Name|
#      |name 1|
#      |name 2|
#      |name 4|
