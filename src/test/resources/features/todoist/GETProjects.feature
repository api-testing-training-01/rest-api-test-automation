Feature: Todoist Projects

  Background:
    Given I use the "todoist" service and the "owner" account
    And I send a "POST" request to "/projects" with datatable
      |name|Test_FV_02|
    And I save the request endpoint for deleting
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

  @negative @regresion
  Scenario: Todoist GET deleted Project
    And I use the "todoist" service and the "owner" account
    When I send a "DELETE" request to "/projects/{LAST_RESPONSE.id}"
    And I send a "GET" request to "/projects/{PROJECT_ID.id}"
    Then I validate the response has status code 404
    And I validate the response contains:
      |  Not Found    |  |