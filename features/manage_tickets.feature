Feature: Manage tickets
  In order to manage tickets
  Visitor
  wants a nice management interface

  Scenario: List tickets
    Given I am an authenticated user with an "admin" role
    Given a client "test client" exists
    And a project "test project" exists with name: "test project", client: client "test client"
    And a ticket exists with project: project "test project", name: "test ticket"
    When I am on the ticket's page
    Then I should see "test ticket"

  Scenario: View a ticket
    Given I am an authenticated user with an "admin" role
    Given a client "test client" exists with name: "test client"
    And a project "test project" exists with name: "test project", client: client "test client"
    And a ticket exists with project: project "test project", name: "test ticket"
    When I am on the ticket's page
    Then I should see a link with text "Back to project: test project" within ".subnav"
    Then I should see a link with text "Back to client: test client" within ".subnav"
    Then I should see a link with text "Edit" within ".subnav"

  Scenario: Edit a ticket
    Given I am an authenticated user with an "admin" role
    Given a client "test client" exists
    And a project "test project" exists with name: "test project", client: client "test client"
    And a ticket exists with project: project "test project", name: "test ticket"
    When I am on the ticket's edit page
    When I fill in "Name" with "test ticket2"
    And I press "Update"
    Then I should see "test ticket2"

  Scenario: Register new ticket
    Given I am an authenticated user with an "admin" role
    Given a client "test client" exists
    And a project exists with name: "test project", client: client "test client"
    And I am assigned to the project
    And I am on the project's page
    And I follow "New Ticket"
    When I fill in "Name" with "name 1"
    And I press "Create"
    Then I should see "name 1"

  Scenario: Register new ticket - the form
    Given I am an authenticated user with an "admin" role
    Given a client "test client" exists
    And a project exists with name: "test project", client: client "test client"
    And I am assigned to the project
    And I am on the project's page
    And I follow "New Ticket"
    Then I should see a link with text "Cancel" within ".actions"

#  Scenario: Delete ticket
#    Given the following tickets:
#      |name|
#      |name 1|
#      |name 2|
#      |name 3|
#      |name 4|
#    When I delete the 3rd ticket
#    Then I should see the following tickets:
#      |Name|
#      |name 1|
#      |name 2|
#      |name 4|
