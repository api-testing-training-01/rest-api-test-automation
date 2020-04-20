Feature: Todoist Sections

  Background:
    Given I use the "todoist" service and the "owner" account
    And I send a "POST" request to "/projects" with datatable
      | name | API Test Project |
    And I save the response as "Project"
    And I save the request endpoint for deleting
    Then I validate the response has status code 200
    When I send a "POST" request to "/sections" with datatable
      | project_id | {Project.id}        |
      | name       | API Testing section |
    And I save the response as "Section"
    Then I validate the response has status code 200

  @cleanData @regression
  Scenario: Getting all Section of all Projects has expected status and schema
    When I send a "GET" request to "/sections"
    Then I validate the response has status code 200
    And Response body should match with "src/test/resources/schemas/todoist/getAllSectionsSchema.json" json schema

  @cleanData @acceptance
  Scenario: Get all Section of all Projects
    When I send a "GET" request to "/sections"
    Then I validate the response has status code 200

  @cleanData @acceptance
  Scenario: Get all Section of all Projects has expected schema
    When I send a "GET" request to "/sections"
    Then I validate the response has status code 200
    And Response body should match with "src/test/resources/schemas/todoist/getAllSectionsSchema.json" json schema



