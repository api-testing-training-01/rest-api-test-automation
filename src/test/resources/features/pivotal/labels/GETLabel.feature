Feature: Get Label

  Background: Create a Pivotal project
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
    When I send a "POST" request to "/projects/{Project.id}/labels" with json body
      """
        {
          "name" : "My auto label"
        }
      """
    And I save the request endpoint for deleting
    Then I validate the response has status code 200
    And I save the response as "Label"

  @acceptance @regression
  Scenario: Pivotal GET Label
    Given I use the "pivotal" service and the "owner" account
    When I send a "GET" request to "/projects/{Project.id}/labels/{Label.id}"
    And I save the request endpoint for deleting
    Then I validate the response has status code 200
    And Response body should match with "src/test/resources/schemas/pivotal/labels/getLabelSchema.json" json schema
    And I validate the response contains, ignoring lower and upper case:
      | name | My auto label |

  @negative @regression
  Scenario: Pivotal GET Label
    Given I use the "pivotal" service and the "owner" account
    When I send a "GET" request to "/projects/{Project.id}/labels/{Label.id}"
    And I save the request endpoint for deleting
    Then I validate the response has status code 200
    And I validate the response should not contain:
      | name | My label created for testing |

  @acceptance @regression
  Scenario: Pivotal GET Labels
    Given I use the "pivotal" service and the "owner" account
    When I send a "GET" request to "/projects/{Project.id}/labels"
      And I save the request endpoint for deleting
    Then I validate the response has status code 200
    And Response body should match with "src/test/resources/schemas/pivotal/labels/getLabelsSchema.json" json schema

  @negative @regression
  Scenario: Pivotal GET Labels
    Given I use the "pivotal" service and the "owner" account
    When I send a "GET" request to "/projects/{Project.id}/labels"
      And I save the request endpoint for deleting
    Then I validate the response has status code 200
    And I validate responses contain, should not be:
      | name | My label created for testing |
