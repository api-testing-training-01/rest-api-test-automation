Feature: Todoist Sections

  Background:
    Given I use the "todoist" service and the "owner" account
    And I send a "POST" request to "/projects" with datatable
      | name | API Test Project |
    And I save the response as "Project"
    And I save the request endpoint for deleting
    Then I validate the response has status code 200

  @cleanData @regression
  Scenario: Updating a Section into Project 'API Test Project'
    Given I send a "POST" request to "/sections" with datatable
      | project_id | {Project.id} |
      | name       | new section  |
    Then I validate the response has status code 200
    And I save the response as "Section"
    When I send a "POST" request to "/sections/{Section.id}" with datatable
      | name | API Testing Updating Section |
#   Then I validate the response has status code 204|
    Then I validate the response has status code 400

  @cleanData @negative
  Scenario: Updating Section that doesn't exist in none Project
    When I send a "POST" request to "/sections/{Project.id}" with datatable
      | name       | new section  |
    Then I validate the response has status code 400

