Feature: Stories

  Background: Pivotal  create a project

    Given I use the "pivotal" service and the "owner" account
    And I send a "POST" request to "/projects" with datatable
      | name | Project for testing |
    And I save the response as "P"
    And I save the request endpoint for deleting

  @cleanData@acceptance
  Scenario: Pivotal POST story with data table
    When I send a "POST" request to "/projects/{P.id}/stories" with datatable
      | name | testing |
    Then I validate the response has status code 200
    And Response body should match with "src/test/resources/schemas/pivotal/poststorySchema.json" json schema
    And I validate the response contains:
      | name | testing |
      | kind | story   |

  @cleanData
  Scenario: Pivotal POST story with empty name data table
    When I send a "POST" request to "/projects/{P.id}/stories" with datatable
      | name |  |
    Then I validate the response has status code 400
    And Response body should match with "src/test/resources/schemas/pivotal/postStoryEmptyNameSchema.json" json schema
    And I validate the response contains:
      | code | invalid_parameter |
      | kind | error   |

  @cleanData
  Scenario: Pivotal POST story duplicate name with data table
    When I send a "POST" request to "/projects/{P.id}/stories" with datatable
      | name | testing |
    Then I validate the response has status code 200
    When I send a "POST" request to "/projects/{P.id}/stories" with datatable
      | name | testing |
    And Response body should match with "src/test/resources/schemas/pivotal/poststorySchema.json" json schema
    And I validate the response contains:
      | name | testing |
      | kind | story   |