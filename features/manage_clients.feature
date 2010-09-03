Feature: Client Management
  As a user
  I should be able to manage clients

  Scenario: List clients
    Given the following clients:
      |name|status|
      |name 1|Good|
      |name 2|Bad|
      |name 3|Ugly|
      |name 4|ANGRY|
    When I visit the clients index page
    Then I should see the following clients:
      |Name|Status|
      |name 1|Good|
      |name 2|Bad|
      |name 3|Ugly|
      |name 4|ANGRY|

  Scenario: View a client
    Given a client "test client" exists
    When I am on the client's page
    Then I should see a link with text "Projects" within "#client"

  Scenario: Register new client
    Given I am on the new client page
    When I fill in "Name" with "name 1"
    And I select "Good" from "Status"
    And I press "Create"
    Then I should see "name 1"
    And I should see "Good"

  Scenario: Register new client - the form
    Given I am on the new client page
    Then I should see a link with text "Cancel" within ".actions"

  Scenario: Delete client
    Given the following clients:
      |name|status|
      |name 1|Good|
      |name 2|Bad|
      |name 3|Ugly|
      |name 4|ANGRY|
    When I delete the 3rd client
    Then I should see the following clients:
      |Name|Status|
      |name 1|Good|
      |name 2|Bad|
      |name 4|ANGRY|
