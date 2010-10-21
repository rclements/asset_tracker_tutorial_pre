Feature: Payroll report
  As an admin user
  I should be able to list unpaid work units for employees

  Scenario: List user with unpaid work unit
    Given I am an authenticated user
    Given a user exist with first_name: "bradley", last_name: "price", email: "bradley@isotope11.com", password: "123456", password_confirmation: "123456"
    Given a client "Test Client" exist with name: "Test Client"
    Given a project "Test Project" exist with name: "Test Project", client: client "Test Client"
    Given a ticket "Test Ticket" exist with name: "Test Ticket", project: project "Test Project"
    Given a work_unit exist with description: "Test Work Unit", ticket: ticket "Test Ticket", hours: 1, scheduled_at: "2010-10-01 00:00:00", created_at: "2010-10-01 00:00:00"
    When I go to the admin payroll index page
    Then show me the page
    Then I should see a link with text "price, bradley"

  Scenario: A user does not have any unpaid work units
    Given I am an authenticated user
    Given a user exist with first_name: "bradley", last_name: "price", email: "bradley@isotope11.com", password: "123456", password_confirmation: "123456"
    Given a client "Test Client" exist with name: "Test Client"
    Given a project "Test Project" exist with name: "Test Project", client: client "Test Client"
    Given a ticket "Test Ticket" exist with name: "Test Ticket", project: project "Test Project"
    Given a work_unit exist with description: "Test Work Unit", ticket: ticket "Test Ticket", hours: 1, scheduled_at: "2010-10-01 00:00:00", created_at: "2010-10-01 00:00:00", paid_at: "2010-11-01 00:00:00", check_number: 1234
    When I go to the admin payroll index page
    Then show me the page
    Then I should not see a link with text "price, bradley"

  Scenario: List users with unpaid work units
    Given I am an authenticated user
    Given the following users exist:
      |first_name |last_name  |middle_initial|email                |password|password_confirmation|
      |bradley    |price      |k             |bradley@isotope11.com|123456  |123456               |
      |jimmy      |johnson    |j             |jimmy@test.com       |123456  |123456               |
      |test       |mctesterson|t             |test@test.com        |123456  |123456               |
      |james      |cook       |j             |james@isotope11.com  |123456  |123456               |
    Given the following clients exist:
      |id|name    |
      |1 |Client 1|
      |2 |Client 2|
      |3 |Client 3|
    Given the following projects exist:
      |id|name              |client|
      |1 |Client 1 Project 1|client: 1     |
      |2 |Client 2 Project 1|2     |
      |3 |Client 2 Project 2|2     |
      |4 |Client 3 Project 1|3     |
    Given the following tickets exist:
      |id|name                       |project|
      |1 |Client 1 Project 1 Ticket 1|1      |
      |2 |Client 2 Project 1 Ticket 1|2      |
      |3 |Client 2 Project 1 Ticket 2|2      |
      |4 |Client 2 Project 2 Ticket 1|3      |
      |5 |Client 3 Project 1 Ticket 1|4      |
      |6 |Client 3 Project 1 Ticket 2|4      |
      |7 |Client 3 Project 1 Ticket 3|4      |
      |8 |Client 3 Project 1 Ticket 4|4      |
    #Given a client exists with name: "test client"
    #And a project exists with name: "test project", client: client "test client"
    #And a ticket exists with name: "test ticket", project: project "test project"
    Given the following work_units exist:
      |ticket|description      |scheduled_at       |hours|user|paid_at            |check_number|
      |1     |test work unit 1 |2010-01-14 00:01:00|2    |1   |                   |            |
      |2     |test work unit 2 |2010-01-14 00:01:00|.5   |1   |2010-02-12 00:00:00|            |
      |3     |test work unit 3 |2010-01-14 00:01:00|3    |2   |                   |            |
      |4     |test work unit 4 |2010-01-14 00:01:00|7    |3   |                   |            |
      |5     |test work unit 5 |2010-01-14 00:01:00|5    |4   |                   |            |
      |6     |test work unit 6 |2010-01-14 00:01:00|12   |1   |                   |            |
      |7     |test work unit 7 |2010-01-14 00:01:00|.5   |1   |                   |            |
      |8     |test work unit 8 |2010-01-14 00:01:00|3.5  |2   |                   |            |
      |9     |test work unit 9 |2010-01-14 00:01:00|5    |3   |                   |            |
      |10    |test work unit 10|2010-01-14 00:01:00|.25  |4   |2010-02-20 00:00:00|1234        |
      |11    |test work unit 11|2010-01-14 00:01:00|2    |1   |                   |            |
      |12    |test work unit 12|2010-01-14 00:01:00|.5   |1   |                   |            |
      |13    |test work unit 13|2010-01-14 00:01:00|3    |2   |                   |1234        |
      |14    |test work unit 14|2010-01-14 00:01:00|.25  |3   |                   |            |
      |15    |test work unit 15|2010-01-14 00:01:00|1    |4   |                   |            |
      |16    |test work unit 16|2010-01-14 00:01:00|2    |1   |                   |            |
      |17    |test work unit 17|2010-01-14 00:01:00|.5   |1   |                   |            |
      |18    |test work unit 18|2010-01-14 00:01:00|3    |2   |                   |1234        |
      |19    |test work unit 19|2010-01-14 00:01:00|1    |3   |                   |            |
      |20    |test work unit 20|2010-01-14 00:01:00|20   |4   |2010-02-20 00:00:00|1234        |
    When I go to the the admin payroll index page
    Then show me the page
    #Then I should see a link with text "Price, Bradley"
    #Then I should see a link with text "Johnson, Jimmy"
    #Then I should see a link with text "Mctesterson, Test"

#  Scenario: Show all unpaid work units for an employee
#    Given I am an authenticated user with "admin" role
#    Given a user exists with name: "NNNNNNAMMMMME" #<----------------------- finish this
#    Given a client "test client" exists
#    And a project "test project" exists with name: "test project", client: client "test client"
#    And a ticket "test ticket" exists with project: project "test project", name: "test ticket"
##...And a work_unit exists with ticket: ticket "test ticket", description: "test work unit", scheduled_at: "2010-01-14 00:01:00", hours: 2, user_id: 1
#    Given the following work_units exist:
#      |ticket|description|scheduled_at|hours|client_id|paid_at|check_number|user|
##...TODO add work units here......
#    When I go to the admin user's show page
#    Then I should see a table with
#
