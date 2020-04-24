Feature: Group

  @acceptance
  Scenario: SFDC Get Group by ID
    Given I use the "sfdc" service and the "owner" account
    When I send a "POST" request to "/Group" with json body
    """
      {
      "Name" : "Group1"
      }
    """
    Then I validate the response has status code 201
    And I save the response as "G"
    When I send a "GET" request to "/Group/{G.id}"
    Then I validate the response has status code 200
    And Response body should match with "src/test/resources/schemas/sfdc/getGroupID.json" json schema
    Then I send a "DELETE" request to "/Group/{G.id}"

  @acceptance
  Scenario: SFDC Get recent Group
    Given I use the "sfdc" service and the "owner" account
    When I send a "POST" request to "/Group" with json body
    """
      {
      "Name" : "Group1"
      }
    """
    Then I validate the response has status code 201
    And I save the response as "G"
    When I send a "GET" request to "/Group/"
    Then I validate the response has status code 200
    And Response body should match with "src/test/resources/schemas/sfdc/getRecentGroup.json" json schema
    Then I send a "DELETE" request to "/Group/{G.id}"

  @acceptance
  Scenario: SFDC Get object describe from Group
    Given I use the "sfdc" service and the "owner" account
    When I send a "POST" request to "/Group" with json body
    """
      {
      "Name" : "Group1"
      }
    """
    Then I validate the response has status code 201
    And I save the response as "G"
    When I send a "GET" request to "/Group/describe"
    Then I validate the response has status code 200
    And Response body should match with "src/test/resources/schemas/sfdc/getDescribeGroup.json" json schema
    Then I send a "DELETE" request to "/Group/{G.id}"

  @negative
    Scenario Outline: SFDC Get Group using incorrect ID
      Given I use the "sfdc" service and the "owner" account
      When I send a "GET" request to "/Group/<wrongID>"
      Then I validate the response has status code 404
     Examples:
       | wrongID        |
       | 123            |
       | notExistent    |
       | ID$%#          |
       | mail@local.com |