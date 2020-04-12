Feature: Delete Label
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
    And I save the response as "Label"
    And I save the request endpoint for deleting


  Scenario: Pivotal, delete label
    Given I use the "pivotal" service and the "owner" account
    When I send a "DELETE" request to "/projects/{Project.id}/labels/{Label.id}"
    Then I validate the response has status code 204
