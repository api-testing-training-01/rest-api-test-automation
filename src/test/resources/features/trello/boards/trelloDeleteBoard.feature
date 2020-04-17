Feature: Boards

  Background:
    Given I use the "trello" service and the "owner" account
    And I send a "POST" request to "/boards" with json body
        """
        {
        "name": "Default"
        }
        """
    And I save the response as "P"
  @acceptance
  Scenario: Delete a board
    When I send a "DELETE" request to "/boards/{P.id}"
    Then I validate the response has status code 200
