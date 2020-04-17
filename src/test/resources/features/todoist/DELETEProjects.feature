Feature: Todoist Projects

  Background:
    Given I use the "todoist" service and the "owner" account
    And I send a "POST" request to "/projects" with datatable
      |name|Test_FV_02|
    And I save the request endpoint for deleting
  @acceptance
  Scenario: Todoist DELETE Project
    And I use the "todoist" service and the "owner" account
    When I send a "DELETE" request to "/projects/{LAST_RESPONSE.id}"
    Then I validate the response has status code 204
