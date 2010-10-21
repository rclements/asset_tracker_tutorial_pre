Feature: Payroll report
  As an admin user
  I should be able to list unpaid work units for employees

  @wip
  Scenario: List users with unpaid work units
    Given I am an authenticated user with "admin" role
    Given the following users exist:
      |first_name|last_name|middle_initial|email|password|role|
    # TODO add users here......
    Given a client "test client" exists
    And a project "test project" exists with name: "test project", client: client "test client"
    And a ticket "test ticket" exists with project: project "test project", name: "test ticket"
    And a work_unit exists with ticket: ticket "test ticket", description: "test work unit", scheduled_at: "2010-01-14 00:01:00", hours: 2, user_id: 1
    Given the following work_units exist:
      |ticket|description|scheduled_at|hours|user|
    # TODO add work units here......
    When I go to the the admin payroll index page
    Then I should see the following ordered list:
#     1. Dill, Adam
#     2. Foret, Laird
#     3. Heitzke, Mike
#     4. Holley, Ben

  @wip
  Scenario: Show all unpaid work units for an employee
    Given I am an authenticated user with "admin" role
    Given a user exists with name: "NNNNNNAMMMMME" #<----------------------- finish this
    Given a client "test client" exists
    And a project "test project" exists with name: "test project", client: client "test client"
    And a ticket "test ticket" exists with project: project "test project", name: "test ticket"
    And a work_unit exists with ticket: ticket "test ticket", description: "test work unit", scheduled_at: "2010-01-14 00:01:00", hours: 2, user_id: 1
    Given the following work_units exist:
      |ticket|description|scheduled_at|hours|client_id|paid_at|check_number|user|
    # TODO add work units here......
    When I go to the admin user's show page
    Then I should see a table with

