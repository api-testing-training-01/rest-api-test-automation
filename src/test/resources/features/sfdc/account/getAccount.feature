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
  Scenario: SFDC Get Account the response has expected values and schema
    When I send a "GET" request to "/account/{Account.id}"
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
  Scenario: SFDC Get non existing Account the response has expected Status value
    When I send a "GET" request to "/account/0001"
    And Response body should match with "src/test/resources/schemas/sfdc/account404Schema.json" json schema
    Then I validate the response has status code 404