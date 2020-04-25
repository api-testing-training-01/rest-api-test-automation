Feature: Post Lead

  @cleanData @acceptance @sfdcLead
  Scenario: SFDC POST Account
    Given I use the "sfdc" service and the "owner" account
    When I send a "POST" request to "/Lead" with json body
      """
      {
        "LastName": "IamLeader",
        "Company": "Company for test",
        "Status": "Working - Contacted"
      }
      """
    And I save the request endpoint for deleting
    Then I validate the response has status code 201
    And I save the response as "Lead"
    And Response body should match with "src/test/resources/schemas/sfdc/lead/PostLeadSchema.json" json schema
    And I validate the response contains:
      | success | true |

  @cleanData @negative @sfdcLead
  Scenario: SFDC POST Account
    Given I use the "sfdc" service and the "owner" account
    When I send a "POST" request to "/Lead" with json body
      """
      {
        "LastName": "IamLeader",
        "Company": "Company for test",
        "Status": "Working - Contacted"
      }
      """
    And I save the request endpoint for deleting
    Then I validate the response has status code 201
    And Response body should match with "src/test/resources/schemas/sfdc/lead/PostLeadSchema.json" json schema
    And I validate the response should not contain:
      | success | false |
