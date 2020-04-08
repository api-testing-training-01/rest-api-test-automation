Feature: Projects

  @cleanData @acceptance
  Scenario: Pivotal PUT specific Projects
    Given I use the "pivotal" service and the "owner" account
    When I send a "POST" request to "/projects" with json body
    """
    {
    "name": "Project created by cucumber ready to update"
    }
    """
    Then I validate the response has status code 200
    And I save the response as "PostResponse"
    When I send a "PUT" request to "/projects/{PostResponse.id}" with json body
     """
    {
     "name":"Project updated from API"
    }
    """
    Then I validate the response has status code 200
     And I validate the response contains:
      | name             | Project updated from API                     |
    Then I send a "DELETE" request to "/projects/{PostResponse.id}"
    Then I validate the response has status code 204