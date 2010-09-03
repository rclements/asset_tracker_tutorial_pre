Feature: Manage Work Units
  In order to manage work units
  Visitor
  wants a nice management interface

  Scenario: List work units
    Given a client "test client" exists
    And a project "test project" exists with name: "test project", client: client "test client"
    And a ticket "test ticket" exists with project: project "test project", name: "test ticket"
    And a work_unit exists with ticket: ticket "test ticket", description: "test work unit", scheduled_at: "2010-01-14 00:01:00", hours: 2
    When I am on the client's project's ticket's work_units page
    Then I should see the following work_units:
      |Description    |Hours |
      |test work unit |2.0   |

  Scenario: Register new work unit
    Given a client "test client" exists
    And a project "test project" exists with name: "test project", client: client "test client"
    And a ticket "test ticket" exists with project: project "test project", name: "test ticket"
    Given I am on the client's project's ticket's new work_unit page
    When I fill in "Description" with "test description"
    And I fill in "Hours" with "2"
    And I press "Create"
    Then I should see "test description"

  Scenario: Register new work unit - the form
    Given a client "test client" exists
    And a project "test project" exists with name: "test project", client: client "test client"
    And a ticket "test ticket" exists with project: project "test project", name: "test ticket"
    Given I am on the client's project's ticket's new work_unit page
    Then I should see a link with text "Cancel" within ".actions"

  Scenario: View a work unit
    Given a client "test client" exists with name: "test client"
    And a project "test project" exists with name: "test project", client: client "test client"
    And a ticket "test ticket" exists with project: project "test project", name: "test ticket"
    And a work_unit exists with ticket: ticket "test ticket", description: "test work_unit", hours: 2, scheduled_at: "2010-01-14 00:01:00"
    When I am on the client's project's ticket's work_unit's page
    Then I should see a link with text "Back to ticket: test ticket" within "#work_unit .links"
    Then I should see a link with text "Back to project: test project" within "#work_unit .links"
    Then I should see a link with text "Back to client: test client" within "#work_unit .links"
