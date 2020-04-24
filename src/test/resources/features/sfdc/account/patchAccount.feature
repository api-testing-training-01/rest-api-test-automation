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

  @cleanData @regression
  Scenario: SFDC Patch Account with valid ID the response has expected values and schema
    When I send a "PATCH" request to "/account/{Account.id}" with json body
      """
      {
      "Name": "Name Updated by Cucumber API test"
      }
      """
    Then I validate the response has status code 204
    Then I send a "GET" request to "/account/{Account.id}"
    And I save the response as "AccountResponse"
    Then I validate the response has status code 200
    And Response body should match with "src/test/resources/schemas/sfdc/getAccountSchema.json" json schema
    And I validate the response contains:
      | Id                 | {AccountResponse.Id}                 |
      | Name               | {AccountResponse.Name}               |
      | IsDeleted          | {AccountResponse.IsDeleted}          |
      | OwnerId            | {AccountResponse.OwnerId}            |
      | PhotoUrl           | {AccountResponse.PhotoUrl}           |
      | CreatedDate        | {AccountResponse.CreatedDate}        |
      | CreatedById        | {AccountResponse.CreatedById}        |
      | LastModifiedDate   | {AccountResponse.LastModifiedDate}   |
      | LastModifiedById   | {AccountResponse.LastModifiedById}   |
      | SystemModstamp     | {AccountResponse.SystemModstamp}     |
      | LastViewedDate     | {AccountResponse.LastViewedDate}     |
      | LastReferencedDate | {AccountResponse.LastReferencedDate} |
      | CleanStatus        | {AccountResponse.CleanStatus}        |


  @cleanData @negative
  Scenario: SFDC Patch Account with no valid body, the response has expected status code and schema
    When I send a "PATCH" request to "/account/{Account.id}" with json body
      """
      {
      "XName": "Name Updated by Cucumber API test"
      }
      """
    And Response body should match with "src/test/resources/schemas/sfdc/account400Schema.json" json schema
    Then I validate the response has status code 400

  @cleanData @negative
  Scenario: SFDC Patch Account with log Name as parameter, the response has expected status code and schema
    When I send a "PATCH" request to "/account/{Account.id}" with json body
      """
      {
      "Name": "Name Updated by Cucumber API test  With Long Name as parameter to be validated as not valid number of chars returning an error STRING_TOO_LONG and Status Code 400 adding text to do this too long The following example uses the Composite and Status Code 400 adding text to do this too long The following example uses the Composite and Status Code 400 adding text to do this too long The following example uses the Composite ."
      }
      """
    And Response body should match with "src/test/resources/schemas/sfdc/account400Schema.json" json schema
    Then I validate the response has status code 400

  @cleanData @negative
  Scenario: SFDC Patch Account with no valid ID the response has expected status code and schema
    When I send a "PATCH" request to "/account/0001" with json body
      """
      {
      "Name": "Name Updated by Cucumber API test"
      }
      """
    And Response body should match with "src/test/resources/schemas/sfdc/account404Schema.json" json schema
    Then I validate the response has status code 404
