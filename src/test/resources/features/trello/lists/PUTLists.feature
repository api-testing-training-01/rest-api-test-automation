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
  Scenario: PUT Update a List only with name field
    Then I send a "PUT" request to "/lists/{listResponse.id}" with json body
    """
     {
      "name": "updated name"
     }
     """
    And I save the response as "listResponseUpdated"
    Then I validate the response has status code 200
    And I validate the response contains:
      | id               | {listResponse.id}                             |
      | name             | {listResponseUpdated.name}                    |
    Then I send a "DELETE" request to "/boards/{responseBoard.id}"
    And I validate the response has status code 200

  @acceptance @regression
  Scenario: PUT Update a List with all fields
    Then I send a "PUT" request to "/lists/{listResponse.id}" with json body
    """
     {
      "name": "updated name",
      "closed": true,
      "pos": 1234
     }
     """
    And I save the response as "listResponseUpdated"
    Then I validate the response has status code 200
    And I validate the response contains:
      | id               | {listResponse.id}                             |
      | name             | {listResponseUpdated.name}                    |
      | idBoard          | {responseBoard.id}                            |
      | closed           | {listResponseUpdated.closed}                  |
      | pos              | {listResponseUpdated.pos}                     |
    Then I send a "DELETE" request to "/boards/{responseBoard.id}"
    And I validate the response has status code 200

  @acceptance @regression
  Scenario: PUT Archive a list as "true"
    Given I send a "PUT" request to "/lists/{listResponse.id}/closed" with json body
    """
     {
      "value": true
     }
     """
    And I save the response as "listResponseUpdated"
    Then I validate the response has status code 200
    And I validate the response contains:
      | id               | {listResponse.id}                             |
      | name             | {listResponse.name}                           |
      | idBoard          | {responseBoard.id}                            |
      | closed           | true                                          |
    Then I send a "DELETE" request to "/boards/{responseBoard.id}"
    And I validate the response has status code 200

  @acceptance @regression
  Scenario: PUT Unarchive a list as "false"
    Given I send a "PUT" request to "/lists/{listResponse.id}/closed" with json body
    """
     {
      "value": false
     }
     """
    And I save the response as "listResponseUpdated"
    Then I validate the response has status code 200
    And I validate the response contains:
      | id               | {listResponse.id}                             |
      | name             | {listResponse.name}                           |
      | idBoard          | {responseBoard.id}                            |
      | closed           | false                                         |
    Then I send a "DELETE" request to "/boards/{responseBoard.id}"
    And I validate the response has status code 200

  @acceptance @regression
  Scenario: PUT Move List to Board
    Then I send a "POST" request to "/boards" with json body
        """
        {
        "name": "POST: 2nd BOARD created for move a list"
        }
        """
    And I save the response as "response2ndBoard"
    Then I send a "PUT" request to "/lists/{listResponse.id}/idBoard" with json body
    """
     {
      "value": "{response2ndBoard.id}"
     }
     """
    And I save the response as "listResponseMoved"
    Then I validate the response has status code 200
    And I validate the response contains:
      | id               | {listResponse.id}                             |
      | name             | {listResponse.name}                           |
      | idBoard          | {response2ndBoard.id}                            |
    Then I send a "DELETE" request to "/boards/{responseBoard.id}"
    And I validate the response has status code 200
    And I send a "DELETE" request to "/boards/{response2ndBoard.id}"
    And I validate the response has status code 200

  @negative
  Scenario: PUT Move List to invalid idBoard
    Then I send a "PUT" request to "/lists/{listResponse.id}/idBoard" with json body
    """
     {
      "value": "123456789"
     }
     """
    And I save the response as "listResponseMoved"
    Then I validate the response has status code 400
    Then I send a "DELETE" request to "/boards/{responseBoard.id}"
    And I validate the response has status code 200

  @acceptance @regression
  Scenario: PUT Update a "Name" field on a List
    Then I send a "PUT" request to "/lists/{listResponse.id}/name" with json body
    """
     {
      "value": "PUT: Name updated"
     }
     """
    And I save the response as "listResponseUpdated"
    Then I validate the response has status code 200
    And I validate the response contains:
      | id               | {listResponse.id}                             |
      | name             | {listResponseUpdated.name}                    |
      | closed           | {listResponseUpdated.closed}                  |
      | pos              | {listResponseUpdated.pos}                     |
      | idBoard          | {responseBoard.id}                            |
    Then I send a "DELETE" request to "/boards/{responseBoard.id}"
    And I validate the response has status code 200

  @acceptance @regression
  Scenario: PUT Update a "Pos" field on a List
    Then I send a "PUT" request to "/lists/{listResponse.id}/pos" with json body
    """
     {
      "value": 1234
     }
     """
    And I save the response as "listResponseUpdated"
    Then I validate the response has status code 200
    And I validate the response contains:
      | id               | {listResponse.id}                             |
      | name             | {listResponseUpdated.name}                    |
      | closed           | {listResponseUpdated.closed}                  |
      | pos              | {listResponseUpdated.pos}                     |
      | idBoard          | {responseBoard.id}                            |
    Then I send a "DELETE" request to "/boards/{responseBoard.id}"
    And I validate the response has status code 200

  @acceptance @regression
  Scenario: PUT Update a "Subscribed" field on a List
    Then I send a "PUT" request to "/lists/{listResponse.id}/subscribed" with json body
    """
     {
      "value": true
     }
     """
    And I save the response as "listResponseUpdated"
    Then I validate the response has status code 200
    And I validate the response contains:
      | id               | {listResponse.id}                             |
      | name             | {listResponseUpdated.name}                    |
      | closed           | {listResponseUpdated.closed}                  |
      | pos              | {listResponseUpdated.pos}                     |
      | idBoard          | {responseBoard.id}                            |
    Then I send a "DELETE" request to "/boards/{responseBoard.id}"
    And I validate the response has status code 200