Feature: API - V1 - Client Management
  As a user
  I should be able to manage clients through an API

  Scenario: List clients
    Given the following clients:
      |name  |status|guid|
      |name 1|Good  |1   |
      |name 2|Bad   |2   |
      |name 3|Ugly  |3   |
      |name 4|ANGRY |4   |
    When I go to path "/api/v1/clients.json":
    Then I should see JSON:
      """
      [
        {"client": {
          "name": "name 1",
          "status": "Good",
          "guid": "1"
        }},
        {"client": {
          "name": "name 2",
          "status": "Bad",
          "guid": "2"
        }},
        {"client": {
          "name": "name 3",
          "status": "Ugly",
          "guid": "3"
        }},
        {"client": {
          "name": "name 4",
          "status": "ANGRY",
          "guid": "4"
        }}
      ]
      """

  Scenario: Show client
    Given the following clients:
      |name  |status|guid|
      |name 1|Good  |1a  |
      |name 2|Bad   |2a  |
      |name 3|Ugly  |3a  |
      |name 4|ANGRY |4a  |
    When I go to path "/api/v1/clients/3a.json":
    Then I should see JSON:
      """
      {"client": {
        "name": "name 3",
        "status": "Ugly",
        "guid": "3a"
      }}
      """
