Feature: SFDC Account

  Background:
    Given I use the "sfdc" service and the "owner" account
    When I send a "POST" request to "/account" with json body
      """
      {
      "Name": "Account created by cucumber API test"
      }
      """
    And I save the response as "Account"
    And I save the request endpoint for deleting
    Then I validate the response has status code 201

  @regression
  Scenario: SFDC Delete Account the response has expected values and schema
    When I send a "DELETE" request to "/account/{Account.id}"
    Then I validate the response has status code 204

  @negative
  Scenario: SFDC Delete Account that was already deleted the response has expected values and schema
    When I send a "DELETE" request to "/account/{Account.id}"
    Then I validate the response has status code 204
    Then I send a "DELETE" request to "/account/{Account.id}"
    And Response body should match with "src/test/resources/schemas/sfdc/account404Schema.json" json schema
    Then I validate the response has status code 404

  @cleanData @negative
  Scenario: SFDC Delete Account  that doesn't exist the response has expected values and schema
    When I send a "DELETE" request to "/account/0001"
    And Response body should match with "src/test/resources/schemas/sfdc/account404Schema.json" json schema
    Then I validate the response has status code 404

