#Feature: Projects
#
#  @cleanData
#  Scenario: SFDC POST Account
#    Given I use the "sfdc" service and the "owner" account
#    When I send a "POST" request to "/account" with json body
#      """
#      {
#      "Name": "Account created by cucumber"
#      }
#      """
#      And I save the request endpoint for deleting
#    Then I validate the response has status code 201
#      And Response body should match with "src/test/resources/schemas/examples/sfdcPostAccountSchema.json" json schema
#      And I validate the response contains:
#        | success | true |
