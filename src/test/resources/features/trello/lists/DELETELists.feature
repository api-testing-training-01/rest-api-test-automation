@allListProject
Feature: Lists

  @acceptance @regression
  Scenario: DELETE List with board
    Given I use the "trello" service and the "owner" account
    Then I send a "POST" request to "/boards" with json body
        """
        {
        "name": "TO DELETE: BOARD created for testing proposed"
        }
        """
    And I save the response as "responseBoard"
    Then I send a "POST" request to "/lists" with json body
      """
      {
      "name": "TO DELETE: List created from API",
      "idBoard": "{responseBoard.id}"
      }
      """
    Then I validate the response has status code 200
    Then I send a "DELETE" request to "/boards/{responseBoard.id}"
    And I validate the response has status code 200