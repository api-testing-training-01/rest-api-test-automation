Feature: Group

  @acceptance
  Scenario: SFDC Delete Group by ID
    Given I use the "sfdc" service and the "owner" account
    When I send a "POST" request to "/Group" with json body
    """
      {
      "Name" : "Group1"
      }
    """
    And I save the response as "G"
    When I send a "GET" request to "/Group/{G.id}"
    Then I send a "DELETE" request to "/Group/{G.id}"
    And I validate the response has status code 204