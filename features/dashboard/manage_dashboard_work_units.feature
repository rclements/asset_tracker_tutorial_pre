Feature: Manage work units in the dashboard
  In order to manage work units
  User
  wants a nice dashboard management interface

  Scenario: List work units
    Given a client "test client" exists with name: "test client"
    And a project "test project" exists with name: "test project", client: client "test client"
    And a ticket "test ticket" exists with project: project "test project", name: "test ticket"
    And a work_unit exists with ticket: ticket "test ticket", description: "test work_unit", hours: 2, scheduled_at: "2010-01-14 00:01:00"
    When I am on the dashboard work_units page
    Then I should see "Recent Work" within "#recent_work"
    Then I should see "Add Work Unit" within "#add_work_unit"
    Then I should see a link with text "[test client] - 2.0 hours - test work_unit" within "#recent_work ul.work_units"

  Scenario: Create work unit
    Given a client "test client" exists
    And a project "test project" exists with name: "test project", client: client "test client"
    And a ticket "test ticket" exists with project: project "test project", name: "test ticket"
    When I am on the dashboard work_units page
    When I fill in "Description" with "test description"
    When I fill in "Hours" with "2"
    And I select "test ticket" from "Ticket"
    And I press "Create"
    Then I should see "test description" within "#recent_work ul.work_units"
