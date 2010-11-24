Feature: Comment Management                                                                                                                                                                                                                As a user
  I should be able to view and make comments

  Scenario: List and add comments
    Given I am an authenticated user
    And a client "test client" exists
    And the following comments:
      |  title  |    comment      |  user_id  | commentable_id | commentable_type | active |
      |  first1 | blah blah blah  |  1        |    15           |  Client          | true   |
      |  first2 | bleh bleh bleh  |  1        |    15           |  Client          | true   |
      |  first3 | blue blue blue  |  1        |    15           |  Client          | true   |
      |  first4 | bale bale bale  |  1        |    15           |  Client          | true   |
    And I am on the client's page
    Then I should see "blah blah blah"
    And I follow "Add Comment"
    When I fill in the following:
      | comment_comment  | This is a test comment! |
    And I press "Post Comment"
    Then I should see "This is a test comment!"


  Scenario: Hide a comment
    Given I am an authenticated user
    And a client "test client" exists
    And the following comments:
      |  title  |    comment      |  user_id  | commentable_id | commentable_type | active |
      |  first1 | blah blah blah  |  1        |    16           |  Client          | true   |
    And I am on the client's page
    When I press "Hide Comment"
    Then I should not see "blah blah blah"
    
