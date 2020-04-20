Feature: SalesForce Opportunity

  Background:
    Given I use the "sfdc" service and the "owner" account
    When I send a "POST" request to "/Opportunity" with json body
      """
      { "Name":"Opportunity To Update","CloseDate":"2015-03-02","StageName":"Prospecting","Probability":10 }
      """
    Then I validate the response has status code 201
    And I save the response as "Op"
    And I save the created request endpoint for deleting

  @cleanData @acceptance
  Scenario: Update Opportunity
    When I send a "PATCH" request to "/Opportunity/{Op.id}" with json body
      """
        {
          "IsPrivate": true
        }
      """
    Then I validate the response has status code 204
