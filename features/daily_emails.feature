Feature: Send Daily Email Report

  Scenario: A client receives a daily email of their hours
    Given all emails have been delivered
    And a client "Test Client" exists
    And a contact "Test Contact" exists with client: client "Test Client", email_address: "testcontact@example.com", receives_email: true
    When the daily email goes out to client: "Test Client"
    Then 1 email should be delivered to "testcontact@example.com"
    And the first email should contain "Isotope"

