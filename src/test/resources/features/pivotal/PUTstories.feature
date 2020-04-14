Feature: Stories

  Background: Pivotal  create a project

    Given I use the "pivotal" service and the "owner" account
    And I send a "POST" request to "/projects" with datatable
      | name | Project for testing |
    And I save the response as "P"
    And I save the request endpoint for deleting
    When I send a "POST" request to "/projects/{P.id}/stories" with datatable
      | name | testing |
      | current_state | started        |
    |         estimate      |     1           |
    And I save the response as "S"
    And I save the request endpoint for deleting


  @cleanData@acceptance
  Scenario: Pivotal PUT story name with data table
    When I send a "PUT" request to "/projects/{P.id}/stories/{S.id}" with datatable
      | name          | testing edited |
    Then I validate the response has status code 200
    And Response body should match with "src/test/resources/schemas/pivotal/putStorySchema.json" json schema
    And I validate the response contains:
      | name          | testing edited |

  @cleanData@acceptance
  Scenario: Pivotal PUT story state with data table
    When I send a "PUT" request to "/projects/{P.id}/stories/{S.id}" with datatable
      | current_state | finished     |
    Then I validate the response has status code 200
    And Response body should match with "src/test/resources/schemas/pivotal/putStorySchema.json" json schema
    And I validate the response contains:
      | current_state | finished       |