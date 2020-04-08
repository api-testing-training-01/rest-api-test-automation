Feature: Projects

  @cleanData  @acceptance
  Scenario: Pivotal DELETE Project
    Given I use the "pivotal" service and the "owner" account
    When I send a "POST" request to "/projects" with json body
    """
    {
    "name": "Basic project created by cucumber"
    }
    """
     Then I validate the response has status code 200
       And I save the response as "PostResponse"
    When I send a "DELETE" request to "/projects/{PostResponse.id}"
        Then I validate the response has status code 204

