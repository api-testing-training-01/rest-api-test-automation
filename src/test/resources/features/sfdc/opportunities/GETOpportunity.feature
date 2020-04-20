Feature: SalesForce Opportunity

  Background:
    Given I use the "sfdc" service and the "owner" account
    When I send a "POST" request to "/Opportunity" with json body
      """
      { "Name":"An Opportunity","CloseDate":"2015-03-02","StageName":"Prospecting","Probability":10 }
      """
    Then I validate the response has status code 201
    And I save the response as "Op"
    And I save the created request endpoint for deleting

  @cleanData @acceptance
  Scenario: Get Opportunity by ID
    When I send a "GET" request to "/Opportunity/{Op.id}"
    Then I validate the response has status code 200
    And Response body should match with "src/test/resources/schemas/sfdc/sfdcGetOpportunitySchema.json" json schema
    And I validate the response contains:
      | StageName | Prospecting |

  @cleanData @regression
  Scenario: Recent items Opportunity
    When I send a "GET" request to "/Opportunity"
    Then I validate the response has status code 200
    And I validate the response contains:
      | Name | An Opportunity |

  @cleanData @negative
  Scenario: Non-existing Opportunity
    When I send a "GET" request to "/Opportunity/0065w00002279RyAAI"
    Then I validate the response has status code 404

