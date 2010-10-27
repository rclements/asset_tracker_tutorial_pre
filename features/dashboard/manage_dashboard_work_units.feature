Feature: Manage work units in the dashboard
  In order to manage work units
  User
  wants a nice dashboard management interface

  Scenario: List work units
    Given I am an authenticated user
    Given a client "test client" exists with name: "test client"
    And a project "test project" exists with name: "test project", client: client "test client"
    And a ticket "test ticket" exists with project: project "test project", name: "test ticket"
    And a work_unit exists with ticket: ticket "test ticket", description: "test work_unit", hours: 2, scheduled_at: "2010-01-14 00:01:00"
    When I am on the dashboard work_units page
    Then I should see "Recent Work" within "#recent_work"
    And I should see "Add Work Unit" within "#add_work_unit"
    And I should see a link with text "[test client] - 2.0 hours - test work_unit" within "#recent_work ul.work_units"

  Scenario: List work units in a specific date range
    Given I am an authenticated user
    Given a client "test client" exists with name: "test client"
    And a project "test project" exists with name: "test project", client: client "test client"
    And a ticket "test ticket" exists with project: project "test project", name: "test ticket"
    And a work_unit exists with ticket: ticket "test ticket", description: "test work_unit", hours: 2, scheduled_at: "2010-01-14 00:01:00"
    And a work_unit exists with ticket: ticket "test ticket", description: "test work_unit earlier", hours: 2, scheduled_at: "2010-01-13 00:01:00"
    When I go to path "/dashboard/work_units?start_date=2010-01-14&end_date=2010-01-14"
    Then I should see "Recent Work" within "#recent_work"
    And I should see "Add Work Unit" within "#add_work_unit"
    And I should see a link with text "[test client] - 2.0 hours - test work_unit" within "#recent_work ul.work_units"
    And I should not see a link with text "[test client] - 2.0 hours - test work_unit earlier" within "#recent_work ul.work_units"

  Scenario: Create work unit
    Given I am an authenticated user
    Given a client "test client" exists
    And a project "test project" exists with name: "test project", client: client "test client"
    And a ticket "test ticket" exists with project: project "test project", name: "test ticket"
    When I am on the dashboard work_units page
    And I fill in "Description" with "test description"
    And I fill in "Hours" with "2"
    And I select "test ticket" from "Ticket"
    And I press "Create"
    Then I should see "test description" within "#recent_work ul.work_units"

  Scenario: Failed creation of work unit
    Given I am an authenticated user
    Given a client "test client" exists
    And a project "test project" exists with name: "test project", client: client "test client"
    And a ticket "test ticket" exists with project: project "test project", name: "test ticket"
    When I am on the dashboard work_units page
    And I press "Create"
    Then I should see "There was a problem" within "#flash_error"

  Scenario: View work unit
    Given I am an authenticated user
    Given a client "test client" exists with name: "test client"
    And a project "test project" exists with name: "test project", client: client "test client"
    And a ticket "test ticket" exists with project: project "test project", name: "test ticket"
    And a work_unit exists with ticket: ticket "test ticket", description: "test work_unit", hours: 2, scheduled_at: "2010-01-14 00:01:00"
    When I am on the dashboard work_unit's page
    Then I should see "test work_unit" within "#work_unit"
    And I should see "test project" within "#work_unit"
    And I should see "test client" within "#work_unit"
    And I should see a link with text "Back to work units" within "#work_unit .actions"
