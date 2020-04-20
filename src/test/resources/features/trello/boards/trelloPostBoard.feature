Feature: Boards

  Background:
    Given I use the "trello" service and the "owner" account

  @acceptance
 Scenario: Post Boards creates a new board
   When I send a "POST" request to "/boards" with json body
      """
      {
      "name": "New Board from API",
      "desc": "Description created"
      }
      """
   And I save the response as "P"
   Then I validate the response has status code 200
    And Response body should match with "src/test/resources/schemas/trello/postSchema.json" json schema
   And I send a "DELETE" request to "/boards/{P.id}"
   And I validate the response has status code 200
