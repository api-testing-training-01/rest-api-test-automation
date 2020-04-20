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

  @acceptance @cleanData
  Scenario: Trello Put Cards on To DO List
    Given I send a "POST" request to "/cards?idList={L.[0].id}" with json body
    """
    {
    "name": "Card1 on To Do",
    "desc": "Description for Card1 on To Do"
    }
    """
    And I save the response as "C"
    When I send a "PUT" request to "/cards/{C.id}" with json body
    """
    {
    "name": "Name modified on Card1 To Do",
    "desc": "Description modified for Card1 on To Do"
    }
    """
    Then I validate the response has status code 200
    And Response body should match with "src/test/resources/schemas/trello/putCard.json" json schema

  @acceptance @cleanData
  Scenario: Trello Put Cards on Doing List
    Given I send a "POST" request to "/cards?idList={L.[1].id}" with json body
    """
    {
    "name": "Card1 on Doing",
    "desc": "Description for Card1 on Doing"
    }
    """
    And I save the response as "C"
    When I send a "PUT" request to "/cards/{C.id}" with json body
    """
    {
    "name": "Name modified on Card1 Doing",
    "desc": "Description modified for Card1 on Doing"
    }
    """
    Then I validate the response has status code 200
    And Response body should match with "src/test/resources/schemas/trello/putCard.json" json schema

  @acceptance @cleanData
  Scenario: Trello Put Cards on Done List
    Given I send a "POST" request to "/cards?idList={L.[2].id}" with json body
    """
    {
    "name": "Card1 on Done",
    "desc": "Description for Card1 on Done"
    }
    """
    And I save the response as "C"
    When I send a "PUT" request to "/cards/{C.id}" with json body
    """
    {
    "name": "Name modified on Card1 Done",
    "desc": "Description modified for Card1 on Done"
    }
    """
    Then I validate the response has status code 200
    And Response body should match with "src/test/resources/schemas/trello/putCard.json" json schema

  @negative @cleanData
  Scenario Outline: Trello Try to update cards with not existent ID or incorrect
    When I send a "PUT" request to "/cards/<ID>" with json body
    """
    {
    "name": "Name modified on Card1 Done",
    "desc": "Description modified for Card1 on Done"
    }
    """
    Then I validate the response has status code <StatusCode>
    Examples:
      | StatusCode | ID         |
      | 400        | 123456     |
      | 400        | IDNotExist |
      | 400        | P%$#*@456  |