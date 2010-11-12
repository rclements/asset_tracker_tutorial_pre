Feature: Invoices
  As an administrator
  I should be able to view and create invoices

  @javascript
  Scenario: Create an invoice
    Given I am an authenticated user with an "admin" role
    And a client "test client" exists with name: "test client", initials: "TTC"
    And a project "test project" exists with name: "test project", client: client "test client"
    And a ticket "test ticket" exists with project: project "test project", name: "test ticket"
    And a work_unit "test work unit" exists with ticket: ticket "test ticket", scheduled_at: "2010-01-01", hours: "1"
    And I am on the admin invoices page
    Then I should see "test client"
    And I follow "test client"
    And I fill in "global_invoiced" with "123"
    And I press "Submit"
    Given I am on the admin invoices page
    Then I should not see "test client"

  Scenario: View clients with uninvoiced work units
    Given I am an authenticated user with an "admin" role
    And a client "test client" exists with name: "test client", initials: "TTC"
    And a project "test project" exists with name: "test project", client: client "test client"
    And a ticket "test ticket" exists with project: project "test project", name: "test ticket"
    And a work_unit "test work unit" exists with ticket: ticket "test ticket", scheduled_at: "2010-01-01", hours: "1"
    And I am on the admin invoices page
    Then I should see "test client"
