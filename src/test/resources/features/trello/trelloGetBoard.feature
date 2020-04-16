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
   Scenario: Get Boards by ID
     When I send a "GET" request to "/boards/{P.id}"
     Then I validate the response has status code 200
     And Response body should match with "src/test/resources/schemas/trello/getSchema.json" json schema
     And I send a "DELETE" request to "/boards/{P.id}"
     And I validate the response has status code 200

  Scenario: Get a field on a Board
      When I send a "GET" request to "/boards/{P.id}/url"
      Then I validate the response has status code 200
      And I send a "DELETE" request to "/boards/{P.id}"
      And I validate the response has status code 200

  Scenario: Get Actions of a Board
    When I send a "GET" request to "/boards/{P.id}/actions"
    Then I validate the response has status code 200
    And I send a "DELETE" request to "/boards/{P.id}"
    And I validate the response has status code 200

  Scenario:  Get Labels on a Board
    When I send a "GET" request to "/boards/{P.id}/labels"
    Then I validate the response has status code 200
    And I send a "DELETE" request to "/boards/{P.id}"
    And I validate the response has status code 200

  Scenario:  Get Checklist on a Board
    When I send a "GET" request to "/boards/{P.id}/checklists"
    Then I validate the response has status code 200
    And I send a "DELETE" request to "/boards/{P.id}"
    And I validate the response has status code 200
  @negative
  Scenario:  404 when Id is valid but not found
    When I send a "GET" request to "/boards/5e852a483857ac6577a77d59"
    Then I validate the response has status code 404
    And I send a "DELETE" request to "/boards/{P.id}"
    And I validate the response has status code 200

  @negative
  Scenario:  400 when Id is invalid
    When I send a "GET" request to "/boards/123456"
    Then I validate the response has status code 400
    And I send a "DELETE" request to "/boards/{P.id}"
    And I validate the response has status code 200


