Feature: Cards

  Background:
    Given I use the "trello" service and the "owner" account
    And I send a "POST" request to "/boards" with json body
   """
   {
    "name": "New Board from IntellIJ"
    }
    """
    Then I validate the response has status code 200
    And I save the response as "B"
    And I save the request endpoint for deleting
    Then I send a "GET" request to "/boards/{B.id}/lists"
    And I save the response as "L"


  @acceptance
  Scenario: Trello Delete Card on To Do List
    Given I send a "POST" request to "/cards?idList={L.[0].id}" with json body
    """
    {
    "name": "Card1 on To Do",
    "desc": "Description for Card1 on To Do"
    }
    """
    And I save the response as "C"
    When I send a "DELETE" request to "/cards/{C.id}"
    Then I validate the response has status code 200
    And Response body should match with "src/test/resources/schemas/trello/deleteCard.json" json schema

  @acceptance
  Scenario: Trello Delete Card on Doing List
    Given I send a "POST" request to "/cards?idList={L.[1].id}" with json body
    """
    {
    "name": "Card1 on To Do",
    "desc": "Description for Card1 on To Do"
    }
    """
    And I save the response as "C"
    When I send a "DELETE" request to "/cards/{C.id}"
    Then I validate the response has status code 200
    And Response body should match with "src/test/resources/schemas/trello/deleteCard.json" json schema

  @acceptance
  Scenario: Trello Delete Card on Done List
    Given I send a "POST" request to "/cards?idList={L.[2].id}" with json body
    """
    {
    "name": "Card1 on To Do",
    "desc": "Description for Card1 on To Do"
    }
    """
    And I save the response as "C"
    When I send a "DELETE" request to "/cards/{C.id}"
    Then I validate the response has status code 200
    And Response body should match with "src/test/resources/schemas/trello/deleteCard.json" json schema

  @negative @cleanData
  Scenario Outline: Trello Try Delete Card - Non existent ID or Incorrect ID
    When I send a "DELETE" request to "/cards/<ID>"
    Then I validate the response has status code <StatusCode>
    Examples:
      | StatusCode | ID         |
      | 400        | 123456     |
      | 400        | IDNotExist |
      | 400        | P%$#*@456  |



