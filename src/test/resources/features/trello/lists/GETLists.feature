@allListProject
Feature: Lists

  Background:
    Given I use the "trello" service and the "owner" account
    Then I send a "POST" request to "/boards" with json body
        """
        {
        "name": "GET: BOARD created for testing proposed"
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
  Scenario: GET a List
    Given I send a "GET" request to "/lists/{listResponse.id}"
    Then I validate the response has status code 200
    Then I send a "DELETE" request to "/boards/{responseBoard.id}"
    And I validate the response has status code 200

  @acceptance
   Scenario: GET Actions for a List
     Given I send a "GET" request to "/lists/{listResponse.id}/actions"
     Then I validate the response has status code 200
     Then I send a "DELETE" request to "/boards/{responseBoard.id}"
     And I validate the response has status code 200

  @acceptance
   Scenario: GET the Board a List is on
     Given I send a "GET" request to "/lists/{listResponse.id}/board"
     Then I validate the response has status code 200
     Then I send a "DELETE" request to "/boards/{responseBoard.id}"
     And I validate the response has status code 200

  @acceptance
   Scenario: GET Actions for a List
     Given I send a "GET" request to "/lists/{listResponse.id}/cards"
     Then I validate the response has status code 200
     Then I send a "DELETE" request to "/boards/{responseBoard.id}"
     And I validate the response has status code 200