Feature: Group

  @acceptance
  Scenario Outline: SFDC Post a Group
    Given I use the "sfdc" service and the "owner" account
    When I send a "POST" request to "/Group" with json body
    """
    {
    "Name" : "<name>",
    "DeveloperName" : "<devName>"
    }
    """
    And I save the response as "G"
    Then I validate the response has status code 201
    And Response body should match with "src/test/resources/schemas/sfdc/postGroup.json" json schema
    And I validate the response contains:
      | success | true |
    And I send a "DELETE" request to "/Group/{G.id}"
    And I validate the response has status code 204
    Examples:
      | name                        | devName                     |
      | Group1                      | Group1                      |
      | Group Long Name 12345678910 | Group_Long_Name_12345678910 |
      | Group1                      | Group1_different_devName    |


  @negative @cleanData
  Scenario Outline: SFDC Post a Group - negative test
    Given I use the "sfdc" service and the "owner" account
    When I send a "POST" request to "/Group" with json body
    """
    {
    "Name" : "<name>",
    "DeveloperName" : "<devName>"
    }
    """
    Then I validate the response has status code 400

    Examples:
      | name                        | devName                     |
      | Group Long Name 12345678910 | Group Long Name 12345678910 |
      | Group1                      | DevName chars %$#@          |
      | GroupName P%$#*@456         | GroupDevName P%$#*@456      |
      | 1                           | 1                           |
      | __                          | __                          |
      | 12345                       | 12345                       |
      |                             |                             |
