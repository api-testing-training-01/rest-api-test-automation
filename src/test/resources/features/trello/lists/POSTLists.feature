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


  @acceptance @regression
  Scenario: POST Create a new List
    Then I validate the response contains:
      | id               | {listResponse.id}                      |
      | name             | {listResponse.name}                    |
      | idBoard          | {responseBoard.id}                     |
    Then I send a "DELETE" request to "/boards/{responseBoard.id}"
    And I validate the response has status code 200

  @acceptance @regression
  Scenario: POST Archive all Cards in List
   Then I send a "POST" request to "/lists/{listResponse.id}/archiveAllCards" with json body
    """
     {
      "idBoard":"{responseBoard.id}",
      "idList": "{listResponse.id}"
     }
     """
    Then I validate the response has status code 200
    Then I send a "DELETE" request to "/boards/{responseBoard.id}"
     And I validate the response has status code 200

   @acceptance @regression
   Scenario: POST Move all Cards in List
    Given I send a "POST" request to "/lists/{listResponse.id}/moveAllCards" with json body
     """
     {
      "idBoard":"{responseBoard.id}",
      "idList": "{listResponse.id}"
     }
     """
     Then I validate the response has status code 200
     Then I send a "DELETE" request to "/boards/{responseBoard.id}"
     And I validate the response has status code 200


  @negative
  Scenario: POST Create a new list with invalid idBoard
    Given I send a "POST" request to "/lists" with json body
     """
      {
      "name": "New List from API with invalid BoardId",
      "idBoard": "123456789"
      }
      """
    Then I validate the response has status code 400
    Then I send a "DELETE" request to "/boards/{responseBoard.id}"
    And I validate the response has status code 200


  @negative
  Scenario: POST Create a new list with idBoard empty
    Given I send a "POST" request to "/lists" with json body
     """
      {
      "name": "New List from API with invalid BoardId",
      "idBoard": ""
      }
      """
    Then I validate the response has status code 400
    Then I send a "DELETE" request to "/boards/{responseBoard.id}"
    And I validate the response has status code 200


  @negative
  Scenario: POST Create a new list with name empty
    Given I send a "POST" request to "/lists" with json body
     """
      {
      "name": "",
      "idBoard": "{responseBoard.id}"
      }
      """
    Then I validate the response has status code 400
    Then I send a "DELETE" request to "/boards/{responseBoard.id}"
    And I validate the response has status code 200


  @negative @regression
  Scenario: POST Create a new list without idBoard
    Given I send a "POST" request to "/lists" with json body
     """
      {
      "name": "New List from API without idBoard"
      }
      """
    Then I validate the response has status code 400
    Then I send a "DELETE" request to "/boards/{responseBoard.id}"
    And I validate the response has status code 200


  @negative @regression
  Scenario: POST Create a new list without name
    Given I send a "POST" request to "/lists" with json body
     """
      {
      "idBoard": "{responseBoard.id}"
      }
      """
    Then I validate the response has status code 400
    Then I send a "DELETE" request to "/boards/{responseBoard.id}"
    And I validate the response has status code 200


  @negative @regression
  Scenario: POST Create a new list if name contains special characters
    Given I send a "POST" request to "/lists" with json body
     """
      {
      "name": "LIST contain special characters:°!#$%&/()=?¡*¨[]_:;><^`~¬*@{}-.,+´¿'",
      "idBoard": "{responseBoard.id}"
      }
      """
    Then I validate the response has status code 200
    Then I send a "DELETE" request to "/boards/{responseBoard.id}"
    And I validate the response has status code 200


  @acceptance @regression
  Scenario: POST Create lists with duplicated name
    Given I send a "POST" request to "/lists" with json body
     """
      {
      "name": "New List from API",
      "idBoard": "{responseBoard.id}"
      }
      """
    Then I validate the response has status code 200
     And I save the response as "listResponseDuplicated"
    Then I validate the response contains:
      | name               | {listResponseDuplicated.name}                      |
    Then I send a "DELETE" request to "/boards/{responseBoard.id}"
    And I validate the response has status code 200


  @acceptance @regression
  Scenario: POST Create more than 1 list within a board
    Given I send a "POST" request to "/lists" with json body
     """
      {
      "name": "New second List created from API",
      "idBoard": "{responseBoard.id}"
      }
      """
    Then I validate the response has status code 200
      And I save the response as "list2Response"
    Then I validate the response contains:
      | name               | {list2Response.name}                      |
      | id                 | {list2Response.id}                        |
    Then I send a "DELETE" request to "/boards/{responseBoard.id}"
    And I validate the response has status code 200


  @negative
  Scenario: POST Archive all Cards in List with empty idBoard
    Then I send a "POST" request to "/lists/{listResponse.id}/archiveAllCards" with json body
    """
     {
      "idBoard":"",
      "idList": "{listResponse.id}"
     }
     """
    Then I validate the response has status code 200
    Then I send a "DELETE" request to "/boards/{responseBoard.id}"
    And I validate the response has status code 200


  @negative
  Scenario: POST Archive all Cards in List with empty idList
    Then I send a "POST" request to "/lists/{listResponse.id}/archiveAllCards" with json body
    """
     {
      "idBoard":"{responseBoard.id}",
      "idList": ""
     }
     """
    Then I validate the response has status code 200
    Then I send a "DELETE" request to "/boards/{responseBoard.id}"
    And I validate the response has status code 200

  @negative
  Scenario: POST Archive all Cards in List sending without idBoard at request
    Then I send a "POST" request to "/lists/{listResponse.id}/archiveAllCards" with json body
    """
     {
      "idList": "{listResponse.id}"
     }
     """
    Then I validate the response has status code 200
    Then I send a "DELETE" request to "/boards/{responseBoard.id}"
    And I validate the response has status code 200


  @negative
  Scenario: POST Archive all Cards in List sending without idList at request
    Then I send a "POST" request to "/lists/{listResponse.id}/archiveAllCards" with json body
    """
     {
      "idBoard":"{responseBoard.id}"
     }
     """
    Then I validate the response has status code 200
    Then I send a "DELETE" request to "/boards/{responseBoard.id}"
    And I validate the response has status code 200