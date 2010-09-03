Feature: Manage projects
  In order to manage projects
  Visitor
  wants a nice management interface

  Scenario: List projects
    Given a client "test client" exists
    And a project exists with name: "test project", client: client "test client"
    When I am on the client's projects page
    Then I should see the following projects:
      |Name|
      |test project|

  Scenario: View a project
    Given a client "test client" exists with name: "test client"
    And a project exists with name: "test project", client: client "test client"
    When I am on the client's project's page
    Then I should see a link with text "Tickets" within "#project .links"
    Then I should see a link with text "Back to client: test client" within "#project .links"
    Then I should see a link with text "Edit" within "#project .links"

  Scenario: Edit a project
    Given a client "test client2" exists
    And a project exists with name: "test project", client: client "test client2"
    When I am on the client's project's edit page
    And I fill in "Name" with "project 2"
    And I press "Update"
    Then I should see "project 2"

  Scenario: Register new project
    Given a client "test client" exists
    Given I am on the client's new project page
    When I fill in "Name" with "name 1"
    And I press "Create"
    Then I should see "name 1"

  Scenario: Register new project - the form
    Given a client "test client" exists
    Given I am on the client's new project page
    Then I should see a link with text "Cancel" within ".actions"

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
