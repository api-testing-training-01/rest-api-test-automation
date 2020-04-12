Feature: Put Label

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
    Then I validate the response has status code 200
    And I save the request endpoint for deleting
    And I save the response as "Label"


  Scenario: Pivotal PUT label
    Given I use the "pivotal" service and the "owner" account
    When I send a "PUT" request to "/projects/{Project.id}/labels/{Label.id}" with json body
      """
        {
          "name" : "My auto label modified"
        }
      """
    Then I validate the response has status code 200
    And I save the request endpoint for deleting
    And Response body should match with "src/test/resources/schemas/pivotal/labels/putLabelSchema.json" json schema
    And I validate the response contains:
      | name | My auto label modified |


  Scenario: Pivotal PUT label
    Given I use the "pivotal" service and the "owner" account
    When I send a "PUT" request to "/projects/{Project.id}/labels/{Label.id}" with json body
      """
        {
          "name" : "My auto label modified"
        }
      """
    Then I validate the response has status code 200
    And I save the request endpoint for deleting
    And I validate the response should not contain:
      | name | My auto label |
