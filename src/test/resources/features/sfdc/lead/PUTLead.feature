Feature: Put/PATCH Lead
  Background: Create a Lead
    Given I use the "sfdc" service and the "owner" account
    When I send a "POST" request to "/Lead" with json body
      """
      {
        "LastName": "Lead to delete",
        "Company": "Company for Testing",
        "Status": "Working - Contacted"
      }
      """
    And I save the request endpoint for deleting
    Then I validate the response has status code 201
    And I save the response as "Lead"

  @cleanData @acceptance @sfdcLead
  Scenario: Update Lead fields
    Given I use the "sfdc" service and the "owner" account
    When I send a "PATCH" request to "/Lead/{Lead.id}" with json body
    """
      {
        "Company": "Company Test",
        "Status": "Open - Not Contacted"
      }
    """
    Then I validate the response has status code 204
    When I send a "GET" request to "/Lead/{Lead.id}"
    And I validate the response contains:
      | Company | Company Test         |
      | Status  | Open - Not Contacted |

  @cleanData @negative @sfdcLead
  Scenario: Update Lead fields
    Given I use the "sfdc" service and the "owner" account
    When I send a "PATCH" request to "/Lead/{Lead.id}" with json body
    """
      {
        "Company": "Company Test",
        "Status": "Open - Not Contacted"
      }
    """
    Then I validate the response has status code 204
    When I send a "GET" request to "/Lead/{Lead.id}"
    And I validate the response should not contain:
      | Company | Company for Testing |
      | Status  | Working - Contacted |
