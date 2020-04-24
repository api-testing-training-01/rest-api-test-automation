Feature: Group

  @acceptance
  Scenario: SFDC Update Group by ID
    Given I use the "sfdc" service and the "owner" account
    When I send a "POST" request to "/Group" with json body
    """
    {
     "Name" : "Group1",
     "DeveloperName" : "DevNameGroup1"
    }
    """
    Then I validate the response has status code 201
    And I save the response as "G"
    When I send a "PATCH" request to "/Group/{G.id}" with json body
    """
    {
     "Name" : "Group Name Updated",
     "DeveloperName" : "GroupNameUpdated"
    }
    """
    Then I validate the response has status code 204
    Then I send a "DELETE" request to "/Group/{G.id}"

  @negative
  Scenario Outline: SFDC Post a Group - negative test
    Given I use the "sfdc" service and the "owner" account
    When I send a "POST" request to "/Group" with json body
    """
    {
     "Name" : "Group1",
     "DeveloperName" : "DevNameGroup1"
    }
    """
    And I save the response as "G"
    When I send a "PATCH" request to "/Group/{G.id}" with json body
    """
    {
    "Name" : "<name>",
    "DeveloperName" : "<devName>"
    }
    """
    Then I validate the response has status code 400
    Then I send a "DELETE" request to "/Group/{G.id}"

    Examples:
      | name                        | devName                     |
      | Group Long Name 12345678910 | Group Long Name 12345678910 |
      | Group1                      | DevName chars %$#@          |
      | GroupName P%$#*@456         | GroupDevName P%$#*@456      |
      | 1                           | 1                           |
      | __                          | __                          |
      | 12345                       | 12345                       |
      |                             |                             |