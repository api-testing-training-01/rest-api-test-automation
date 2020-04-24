Feature: SalesForce Opportunity

  Background:
    Given I use the "sfdc" service and the "owner" account
    When I send a "POST" request to "/Opportunity" with json body
      """
      { "Name":"To delete Opportunity","CloseDate":"2015-03-02","StageName":"Prospecting","Probability":10 }
      """
    Then I validate the response has status code 201
    And I save the response as "Op"
    And I save the request endpoint for deleting

  @cleanData @acceptance
  Scenario: Delete Opportunity
    When I send a "DELETE" request to "/Opportunity/{Op.id}"
    Then I validate the response has status code 204