Feature: Delete Lead
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
  Scenario: Delete a Lead
    Given I use the "sfdc" service and the "owner" account
    When I send a "DELETE" request to "/Lead/{Lead.id}"
    And I save the request endpoint for deleting
    Then I validate the response has status code 204

  @cleanData @negative @sfdcLead
  Scenario: Delete a Lead
    Given I use the "sfdc" service and the "owner" account
    When I send a "DELETE" request to "/Lead/{Lead.id}"
    And I save the request endpoint for deleting
    Then I validate the response should not have status code
      |201|
      |404|
