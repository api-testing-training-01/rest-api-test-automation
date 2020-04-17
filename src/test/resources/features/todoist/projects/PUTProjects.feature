Feature: Todoist Projects

  Background:
    Given I use the "todoist" service and the "owner" account
    And I send a "POST" request to "/projects" with datatable
      |name|Test_FV_02|
    And I save the request endpoint for deleting
    And I save the response as "P"
  @cleanData @acceptance
  Scenario: Todoist PUT Project
    And I use the "todoist" service and the "owner" account
    When I send a "POST" request to "/projects" with datatable
      | project_id  | {P.id}             |
      |name         |Test_FV_name_updated|
    Then I validate the response has status code 400