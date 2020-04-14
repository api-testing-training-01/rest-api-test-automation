Feature: Stories

  Background: Pivotal  create a project

    Given I use the "pivotal" service and the "owner" account
    And I send a "POST" request to "/projects" with datatable
      | name | Project for testing |
    And I save the response as "P"
    And I save the request endpoint for deleting
    When I send a "POST" request to "/projects/{P.id}/stories" with datatable
      | name | testing |
    And I save the response as "S"
    And I save the request endpoint for deleting

  @cleanData@acceptance
  Scenario: Pivotal DELETE story with data table
    When I send a "DELETE" request to "/projects/{P.id}/stories/{S.id}"
    Then I validate the response has status code 204

  @cleanData
  Scenario: Pivotal DELETE story already deleted with data table
    When I send a "DELETE" request to "/projects/{P.id}/stories/{S.id}"
    Then I validate the response has status code 204
    When I send a "DELETE" request to "/projects/{P.id}/stories/{S.id}"
    Then I validate the response has status code 400
    And Response body should match with "src/test/resources/schemas/pivotal/deleteStoryAlreadyDeletedSchema.json" json schema
    And I validate the response contains:
      | kind         | error                                                                         |
      | possible_fix | The story could have already been moved or deleted, or is in another project. |