Feature: Manage Work Units
  In order to manage work units
  Visitor
  wants a nice management interface

  @javascript
  Scenario: Register new work unit
    Given I am an authenticated user
    And a client "test client" exists with name: "test client", initials: "TTC"
    And a project "test project" exists with name: "test project", client: client "test client"
    And a ticket "test ticket" exists with project: project "test project", name: "test ticket"
    And I am assigned to the project
    And I visit /
    When I select "test client" from "work_unit_client_id"
    And I select "test project" from "work_unit_project_id"
    And I select "test ticket" from "work_unit_ticket_id"
    And I select "Overtime" from "hours_type"
    And I fill in "Hours" with "2"
    And I fill in "work_unit_description" with "test description"
    And I press "Create Work Unit"
    Then I should see "Work Unit created successfully."
    Then I should see "TTC: 3.0" within ".overtime"
