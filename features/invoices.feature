Feature: Invoices
  As an administrator
  I should be able to view and create invoices

  Scenario: Create an invoice
    Given I am an authenticated user with an "admin" role
    And a ticket exists with two uninvoiced work units
    And I am on the admin invoice show page for that ticket
    When I fill in the first invoice field with "Invoice 1000"
    And I fill in the first date field with "10/27/2010"
    And I fill in the second invoice field with ""
    And I fill in the second date field with "10/27/2010"
    And I click "Submit"
    Then I should not see the first work unit
    And I should see the second work unit
