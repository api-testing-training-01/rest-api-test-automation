Feature: Labels

  Background: Pivotal create a project
    Given I use the "pivotal" service and the "owner" account
    When I send a "POST" request to "/projects" with the next json body
      """
        {
          "name": "cucumber IV",
          "public": true,
          "new_account_name": "New Account"
        }
      """
    Then I validate the response status code, should be 200
      And I save the request to delete
      And I store the response as "Project"

  @deleteProject @acceptance
  Scenario: Pivotal POST Labels
    Given I use the "pivotal" service and the "owner" account
    When I send a "POST" request to "/projects/{Project.id}/labels" with the next json body
      """
        {
          "name" : "My first label XXVI"
        }

      """
    And I save the request to delete
    Then I validate the response status code, should be 200
      And The Response body should match with "src/test/resources/schemas/pivotal/labels/postLabelSchema.json" json schema
      And The Response contains should be:
        | name             | My first label XXVI |
        |kind|label|

  @deleteProject @negative
  Scenario: Pivotal POST Labels
    Given I use the "pivotal" service and the "owner" account
    When I send a "POST" request to "/projects/{Project.id}/labels" with the next json body
      """
        {
          "name" : "My first label XXVI"
        }

      """
    And I save the request to delete
    Then I validate the response status code, should be 200
    And The Response contains should not be:
      | name             | &^%$*GJG |
      |kind|project|
