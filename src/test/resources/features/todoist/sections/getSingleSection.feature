Feature: Todoist Sections

  Background:
    Given I use the "todoist" service and the "owner" account
    And I send a "POST" request to "/projects" with datatable
      | name | API Test Project |
    And I save the response as "Project"
    And I save the request endpoint for deleting
    Then I validate the response has status code 200

  @cleanData @Regression
  Scenario: Get specific Section of "API Test Project" has expected status code, data  and schema
    Given I send a "POST" request to "/sections" with datatable
      | project_id | {Project.id}        |
      | name       | API Testing section |
    And I save the response as "Section"
    Then I validate the response has status code 200
    When I send a "GET" request to "/sections/{Section.id}"
    Then I validate the response has status code 200
    And I validate the response contains:
      | id         | {Section.id}        |
      | project_id | {Project.id}        |
      | order      | 1                   |
      | name       | API Testing section |
    And Response body should match with "src/test/resources/schemas/todoist/getSpecificSectionSchema.json" json schema

  @cleanData @acceptance
  Scenario: Get specific Section of "API Test Project" Projects
    Given I send a "POST" request to "/sections" with datatable
      | project_id | {Project.id}        |
      | name       | API Testing section |
    And I save the response as "Section"
    Then I validate the response has status code 200
    When I send a "GET" request to "/sections/{Section.id}"
    Then I validate the response has status code 200
    And I validate the response contains:
      | id         | {Section.id}        |
      | project_id | {Project.id}        |
      | order      | 1                   |
      | name       | API Testing section |

  @cleanData @acceptance
  Scenario: Get specific Section has expected schema
    Given I send a "POST" request to "/sections" with datatable
      | project_id | {Project.id}        |
      | name       | API Testing section |
    And I save the response as "Section"
    Then I validate the response has status code 200
    When I send a "GET" request to "/sections/{Section.id}"
    Then I validate the response has status code 200
    And Response body should match with "src/test/resources/schemas/todoist/getSpecificSectionSchema.json" json schema

  @cleanData @negative
  Scenario: Get non existing Section
    When I send a "GET" request to "/sections/{Project.id}"
    Then I validate the response has status code 404
