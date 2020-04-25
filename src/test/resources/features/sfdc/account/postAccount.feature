Feature: SFDC Account

  @cleanData @regression
  Scenario: SFDC POST Account the response has expected values and schema
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
    And Response body should match with "src/test/resources/schemas/sfdc/postAccountSchema.json" json schema
    And I validate the response contains:
      | id      | {Account.id}      |
      | errors  | {Account.errors}  |
      | success | {Account.success} |


  @cleanData @regression
  Scenario: SFDC POST Account with log name as parameter the response has expected status code and schema
    Given I use the "sfdc" service and the "owner" account
    When I send a "POST" request to "/account" with json body
      """
      {
          "Name": "Account created by cucumber API test With Long Name as parameter to be validated as not valid number of chars returning an error STRING_TOO_LONG and Status Code 400 adding text to do this too long The following example uses the Composite created by cucumber API test With Long Name as parameter to be validated as not valid number of chars returning an error STRING_TOO_LONG and Status Code 400 adding text to do this too long The following example uses the Composite and Status Code 400 adding text to do this too long The following example uses the Composite and Status Code 400 adding text to do this too long The following example uses the Composite ."
      }
      """
    And I save the response as "Account"
    And I save the request endpoint for deleting
    Then I validate the response has status code 400
    And Response body should match with "src/test/resources/schemas/sfdc/account400Schema.json" json schema


  @cleanData @negative
  Scenario: SFDC POST Account without  name as parameter the response has expected status code and schema
    Given I use the "sfdc" service and the "owner" account
    When I send a "POST" request to "/account" with json body
      """
      {
          "XName": "Account created by cucumber API"
      }
      """
    And I save the response as "Account"
    And I save the request endpoint for deleting
    Then I validate the response has status code 400
    And Response body should match with "src/test/resources/schemas/sfdc/account400Schema.json" json schema