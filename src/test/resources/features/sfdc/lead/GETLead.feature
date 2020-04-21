Feature: Get Lead

  Background: Create a Lead
    Given I use the "sfdc" service and the "owner" account
    When I send a "POST" request to "/Lead" with json body
      """
      {
        "LastName": "Lead to delete",
        "Company": "Company for Testing",
        "Status": "Open - Not Contacted"
      }
      """
    And I save the request endpoint for deleting
    Then I validate the response has status code 201
    And I save the response as "Lead"

  @cleanData @acceptance @sfdcLead
  Scenario: Get a Lead
    Given I use the "sfdc" service and the "owner" account
    When I send a "GET" request to "/Lead/{Lead.id}"
    And I save the request endpoint for deleting
    Then I validate the response has status code 200
    And Response body should match with "src/test/resources/schemas/sfdc/lead/GetLeadSchema.json" json schema
    And I validate the response contains:
      | LastName | Lead to delete       |
      | Company  | Company for Testing  |
      | Status   | Open - Not Contacted |

  @cleanData @negative @sfdcLead
  Scenario: Get a Lead
    Given I use the "sfdc" service and the "owner" account
    When I send a "GET" request to "/Lead/{Lead.id}"
    And I save the request endpoint for deleting
    Then I validate the response has no to be status code 400
    And I validate the response should not contain:
      | LastName | Lead to             |
      | Company  | Company for         |
      | Status   | Working - Contacted |
