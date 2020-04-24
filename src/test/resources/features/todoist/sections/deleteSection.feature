Feature: Todoist Sections

  Background:
    Given I use the "todoist" service and the "owner" account
    And I send a "POST" request to "/projects" with datatable
      | name | API Test Project |
    And I save the response as "Project"
    And I save the request endpoint for deleting
    Then I validate the response has status code 200

  @cleanData @regression
  Scenario: Delete specific Section
    Given I send a "POST" request to "/sections" with datatable
      | project_id | {Project.id}        |
      | name       | API Testing section |
    And I save the response as "Section"
    Then I validate the response has status code 200
    When I send a "DELETE" request to "/sections/{Section.id}"
    Then I validate the response has status code 204

  @cleanData @negative
  Scenario: Delete non existing Section
    When I send a "DELETE" request to "/sections/{Project.id}"
    Then I validate the response has status code 400

