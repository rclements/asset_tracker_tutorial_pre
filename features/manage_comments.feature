Feature: Comment Management                                                                                                                                                                                                                As a user
  I should be able to view and make comments

  Scenario: List and add comments
    Given I am an authenticated user with an "admin" role
    And a client "test client" exists
    When I am on the client's page
    And I follow "Add Comment"
    And I fill in the following:
      | comment_comment  | This is a test comment! |
    And I press "Post Comment"
    Then I should see "This is a test comment!"
    When I press "Hide Comment"
    Then I should not see "blah blah blah"

