Feature: SalesForce Opportunity

  @cleanData @acceptance
  Scenario: SFDC POST Opportunity
    Given I use the "sfdc" service and the "owner" account
    When I send a "POST" request to "/Opportunity" with json body
      """
      { "Name":"New Opportunity","CloseDate":"2015-03-02","StageName":"Prospecting","Probability":10 }
      """
    And I save the request endpoint for deleting
    Then I validate the response has status code 201
    And Response body should match with "src/test/resources/schemas/examples/sfdcPostAccountSchema.json" json schema
    And I validate the response contains:
        | success | true |

