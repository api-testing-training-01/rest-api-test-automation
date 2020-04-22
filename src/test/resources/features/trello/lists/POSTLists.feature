@allListProject
Feature: Lists

  Background:
    Given I use the "trello" service and the "owner" account
    Then I send a "POST" request to "/boards" with json body
        """
        {
        "name": "POST: BOARD created for testing proposed"
        }
        """
    And I save the response as "responseBoard"
    Then I send a "POST" request to "/lists" with json body
      """
      {
      "name": "New List from API",
      "idBoard": "{responseBoard.id}"
      }
      """
    Then I validate the response has status code 200
    And I save the response as "listResponse"


  @acceptance
  Scenario: POST Create a new List
    Then I validate the response contains:
      | name             | {listResponse.name}                    |
    Then I send a "DELETE" request to "/boards/{responseBoard.id}"
    And I validate the response has status code 200

#  @acceptance
#  Scenario: POST Archive all Cards in List
#   Then I send a "POST" request to "/lists/5e9fedf673120950f3767e93/archiveAllCards"
#    Then I validate the response has status code 200
#    Then I send a "DELETE" request to "/boards/{responseBoard.id}"
#    And I validate the response has status code 200

   @acceptance
   Scenario: POST Move all Cards in List
    Given I send a "POST" request to "/lists/{listResponse.id}/moveAllCards"
     Then I validate the response has status code 200
     Then I send a "DELETE" request to "/boards/{responseBoard.id}"
     And I validate the response has status code 200