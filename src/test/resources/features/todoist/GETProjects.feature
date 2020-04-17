Feature: Todoist Projects

  Background:
    Given I use the "todoist" service and the "owner" account
    And I send a "POST" request to "/projects" with datatable
      |name|Test_FV_02|
    And I save the request endpoint for deleting
    And I save the response as "P"
  @cleanData @acceptance
  Scenario: Todoist GET Project
    And I use the "todoist" service and the "owner" account
    When I send a "GET" request to "/projects/{LAST_RESPONSE.id}"
    Then I validate the response has status code 200
    And Response body should match with "src/test/resources/schemas/todoist/getSchema.json" json schema
    And I validate the response contains:
      | kind             | project    |
      | name             | Test_FV_02 |

  @cleanData @acceptance
  Scenario: Todoist GET all Project
    And I use the "todoist" service and the "owner" account
    When I send a "GET" request to "/projects"
    Then I validate the response has status code 200

  @cleanData @negative
  Scenario: Todoist GET Project using an invalid ID
    And I use the "todoist" service and the "owner" account
    When I send a "GET" request to "/projects/00002222"
    Then I validate the response has status code 404


  @negative @regresion
  Scenario: Todoist GET deleted Project
    And I use the "todoist" service and the "owner" account
    When I send a "DELETE" request to "/projects/{LAST_RESPONSE.id}"
    And I send a "GET" request to "/projects/{P.id}"
    Then I validate the response has status code 404
