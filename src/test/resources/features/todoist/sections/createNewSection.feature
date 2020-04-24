Feature: Todoist Sections

  Background:
    Given I use the "todoist" service and the "owner" account
    And I send a "POST" request to "/projects" with datatable
      | name | API Test Project |
    And I save the response as "Project"
    And I save the request endpoint for deleting
    Then I validate the response has status code 200

  @cleanData @regression
  Scenario: Create a new Section into Project 'API Test Project' has expected contain and schema
    When I send a "POST" request to "/sections" with datatable
      | project_id | {Project.id}        |
      | name       | API Testing section |
    And I save the response as "Section"
    Then I validate the response has status code 200
    And I validate the response contains:
      | id         | {Section.id}        |
      | project_id | {Project.id}        |
      | order      | 1                   |
      | name       | API Testing section |
    And Response body should match with "src/test/resources/schemas/todoist/createNewSectionSchema.json" json schema

  @cleanData @acceptance
  Scenario: Create a new Section into Project 'API Test Project'
    When I send a "POST" request to "/sections" with datatable
      | project_id | {Project.id}        |
      | name       | API Testing section |
    And I save the response as "Section"
    Then I validate the response has status code 200
    And I validate the response contains:
      | id         | {Section.id}        |
      | project_id | {Project.id}        |
      | order      | 1                   |
      | name       | API Testing section |

  @cleanData @acceptance
  Scenario: Creating a new Section into Project 'API Test Project' has expected schema
    When I send a "POST" request to "/sections" with datatable
      | project_id | {Project.id} |
      | name       | new section  |
    Then I validate the response has status code 200
    And Response body should match with "src/test/resources/schemas/todoist/createNewSectionSchema.json" json schema

  @cleanData @negative
  Scenario: Creating a new Section without 'project_id' parameter
    When I send a "POST" request to "/sections" with datatable
      | project_idX | {Project.id} |
      | name        | new section  |
    Then I validate the response has status code 400

  @cleanData @negative
  Scenario: Creating a new Section without 'name' parameter into Project 'API Test Project'
    When I send a "POST" request to "/sections" with datatable
      | project_id | {Project.id} |
      | Xname      | new section  |
    Then I validate the response has status code 400

  @cleanData @negative
  Scenario: Creating a new Section into non existing Project
    When I send a "POST" request to "/sections" with datatable
      | project_id | {Project.name} |
      | name       | new section    |
    Then I validate the response has status code 400