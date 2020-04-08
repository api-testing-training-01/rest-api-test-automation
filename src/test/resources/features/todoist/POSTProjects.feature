Feature: Todoist Projects

  @cleanData @acceptance
  Scenario: Todoist POST Project
    Given I use the "todoist" service and the "owner" account
    When I send a "POST" request to "/projects" with datatable
      |name|Test_FV_02|
    And I save the request endpoint for deleting
    Then I validate the response has status code 200
    And Response body should match with "src/test/resources/schemas/todoist/postSchema.json" json schema
    And I validate the response contains:
      | kind             | project    |
      | name             | Test_FV_02 |