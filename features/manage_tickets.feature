Feature: Manage tickets
  In order to manage tickets
  Visitor
  wants a nice management interface

  Scenario: List tickets
    Given a client "test client" exists
    And a project "test project" exists with name: "test project", client: client "test client"
    And a ticket exists with project: project "test project", name: "test ticket"
    When I am on the client's project's tickets page
    Then I should see the following tickets:
      |Name|
      |test ticket|

  Scenario: View a ticket
    Given a client "test client" exists with name: "test client"
    And a project "test project" exists with name: "test project", client: client "test client"
    And a ticket exists with project: project "test project", name: "test ticket"
    When I am on the client's project's ticket's page
    Then I should see a link with text "Work Units" within "#ticket .links"
    Then I should see a link with text "Back to project: test project" within "#ticket .links"
    Then I should see a link with text "Back to client: test client" within "#ticket .links"

  Scenario: Register new ticket
    Given a client "test client" exists
    And a project exists with name: "test project", client: client "test client"
    Given I am on the client's project's new ticket page
    When I fill in "Name" with "name 1"
    And I press "Create"
    Then I should see "name 1"

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
