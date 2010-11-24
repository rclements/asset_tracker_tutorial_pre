Feature: File Attachment Management
  As a user
  I should be able to view and add file attachments

  Scenario: List and add file attachments
    Given I am an authenticated user
    And a client "test client" exists
    And the following file attachments:
      |  title  |    comment      |  user_id  | commentable_id | commentable_type | active |
      |  first1 | blah blah blah  |  1        |    15           |  Client          | true   |
      |  first2 | bleh bleh bleh  |  1        |    15           |  Client          | true   |
      |  first3 | blue blue blue  |  1        |    15           |  Client          | true   |
      |  first4 | bale bale bale  |  1        |    15           |  Client          | true   |
    And I am on the client's page
 
