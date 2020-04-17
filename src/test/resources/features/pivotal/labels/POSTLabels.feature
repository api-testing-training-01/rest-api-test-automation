Feature: Labels

  Background: Pivotal create a project
    Given I use the "pivotal" service and the "owner" account
    When I send a "POST" request to "/projects" with json body
      """
        {
          "name": "cucumber IV",
          "public": true,
          "new_account_name": "New Account"
        }
      """
    Then I validate the response has status code 200
      And I save the request endpoint for deleting
      And I save the response as "Project"

  @cleanData @acceptance
  Scenario: Pivotal POST Labels
    Given I use the "pivotal" service and the "owner" account
    When I send a "POST" request to "/projects/{Project.id}/labels" with json body
      """
        {
          "name" : "My first label XXVI"
        }

      """
    And I save the request endpoint for deleting
    Then I validate the response has status code 200
      And Response body should match with "src/test/resources/schemas/pivotal/labels/postLabelSchema.json" json schema
      And I validate the response contains, ignoring lower and upper case:
        | name | My first label XXVI |
        | kind | label               |

  @cleanData @negative
  Scenario: Pivotal POST Labels
    Given I use the "pivotal" service and the "owner" account
    When I send a "POST" request to "/projects/{Project.id}/labels" with json body
      """
        {
          "name" : "My first label XXVI"
        }

      """
    And I save the request endpoint for deleting
    Then I validate the response has status code 200
    And I validate the response should not contain:
      | name | &^%$*GJG |
      | kind | project  |
