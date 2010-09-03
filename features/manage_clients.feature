Feature: Client Management
  As a user
  I should be able to manage clients

  Scenario: List clients
    Given the following clients:
      |name|status|
      |name 1|status 1|
      |name 2|status 2|
      |name 3|status 3|
      |name 4|status 4|
    When I visit the clients index page
    Then I should see the following clients:
      |Name|Status|
      |name 1|status 1|
      |name 2|status 2|
      |name 3|status 3|
      |name 4|status 4|

  Scenario: View a client
    Given a client "test client" exists
    When I am on the client's page
    Then I should see a link with text "Projects" within "#client"

  Scenario: Register new client
    Given I am on the new client page
    When I fill in "Name" with "name 1"
    And I fill in "Status" with "status 1"
    And I press "Create"
    Then I should see "name 1"
    And I should see "status 1"

  Scenario: Register new client - the form
    Given I am on the new client page
    Then I should see a link with text "Cancel" within ".actions"

  Scenario: Delete client
    Given the following clients:
      |name|status|
      |name 1|status 1|
      |name 2|status 2|
      |name 3|status 3|
      |name 4|status 4|
    When I delete the 3rd client
    Then I should see the following clients:
      |Name|Status|
      |name 1|status 1|
      |name 2|status 2|
      |name 4|status 4|
