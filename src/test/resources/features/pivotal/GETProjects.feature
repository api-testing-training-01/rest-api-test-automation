@allPivotalProject
Feature: Projects

  @cleanData @acceptance
  Scenario: Pivotal GET all Projects
    Given I use the "pivotal" service and the "owner" account
    When I send a "GET" request to "/projects"
    Then I validate the response has status code 200

  @cleanData @acceptance
  Scenario: Pivotal GET specific Projects
    Given I use the "pivotal" service and the "owner" account
    When I send a "POST" request to "/projects" with json body
    """
    {
    "name": "Project created by cucumber"
    }
    """
    Then I validate the response has status code 200
    And I save the response as "PostResponse"
    When I send a "GET" request to "/projects/{PostResponse.id}"
      Then I validate the response has status code 200
      Then I send a "DELETE" request to "/projects/{PostResponse.id}"
      Then I validate the response has status code 204

  @cleanData @acceptance
  Scenario: Pivotal GET Projects with number of iteration
    Given I use the "pivotal" service and the "owner" account
    When I send a "POST" request to "/projects" with json body
    """
    {
    "name": "Project created by cucumber"
    }
    """
    Then I validate the response has status code 200
    And I save the response as "PostResponse"
    When I send a "GET" request to "/projects/{PostResponse.id}/iterations/1"
    Then I validate the response has status code 200
    Then I validate the response contains:
      | kind             | iteration                                            |
    Then I send a "DELETE" request to "/projects/{PostResponse.id}"
    Then I validate the response has status code 204

  @cleanData @acceptance
  Scenario: Pivotal GET Projects with iteration and analytics
    Given I use the "pivotal" service and the "owner" account
    When I send a "POST" request to "/projects" with json body
    """
    {
    "name": "Project created by cucumber"
    }
    """
    Then I validate the response has status code 200
    And I save the response as "PostResponse"
    When I send a "GET" request to "/projects/{PostResponse.id}/iterations/1/analytics"
    Then I validate the response has status code 200
    Then I validate the response contains:
      | kind             | analytics                                            |
    Then I send a "DELETE" request to "/projects/{PostResponse.id}"
    Then I validate the response has status code 204

  @cleanData @acceptance
  Scenario: Pivotal GET Projects by memberships
    Given I use the "pivotal" service and the "owner" account
    When I send a "POST" request to "/projects" with json body
    """
    {
    "name": "Project created by cucumber for memberships"
    }
    """
    Then I validate the response has status code 200
    And I save the response as "PostResponse"
    When I send a "GET" request to "/projects/{PostResponse.id}/memberships"
    Then I validate the response has status code 200
    Then I send a "DELETE" request to "/projects/{PostResponse.id}"
    Then I validate the response has status code 204