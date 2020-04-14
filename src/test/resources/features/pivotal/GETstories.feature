Feature: Stories

  Background: Pivotal  create a project

    Given I use the "pivotal" service and the "owner" account
    And I send a "POST" request to "/projects" with datatable
      | name | Project for testing |
    And I save the response as "P"
    And I save the request endpoint for deleting

  @cleanData@acceptance
  Scenario: Pivotal GET story when there is not stories created
    When I send a "GET" request to "/projects/{P.id}/stories"
    Then I validate the response has status code 200
    And Response body should match with "src/test/resources/schemas/pivotal/getNoStoriesCreatedSchema.json" json schema

  @cleanData@acceptance
  Scenario: Pivotal GET an story created in a project
    When I send a "POST" request to "/projects/{P.id}/stories" with datatable
      | name | testing |
    Then I validate the response has status code 200
    When I send a "GET" request to "/projects/{P.id}/stories"
    Then I validate the response has status code 200
    And Response body should match with "src/test/resources/schemas/pivotal/getStoriesSchema.json" json schema
    And I validate response contain:
      | kind | story |

#  @cleanData
#  Scenario: Pivotal GET a specific story in a project
#    When I send a "POST" request to "/projects/{P.id}/stories" with datatable
#      | name       | testing 1 |
#      | story_type | bug       |
#    Then I validate the response has status code 200
#    When I send a "POST" request to "/projects/{P.id}/stories" with datatable
#      | name       | testing 2 |
#      | story_type | release   |
#    Then I validate the response has status code 200
#    When I send a "GET" request to "/projects/{P.id}/stories" with datatable query
#      | filter | story_type:bug|
#    Then I validate the response has status code 200
#    And Response body should match with "src/test/resources/schemas/pivotal/getStoriesSchema.json" json schema
#    And I validate response contain:
#      | kind | story |