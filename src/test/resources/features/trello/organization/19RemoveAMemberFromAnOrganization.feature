@CreateOrganization @CreateMemberInAnOrganization @deletedOrganization
Feature: Remove a Member from an Organization
  Background:
    Given I use the "trello" service and the "owner" account
  @acceptance @regression
  Scenario: Get an Organization
    When I send a "DELETE" request to "/organizations/{Org.id}/members/{Member.memberships[1].idMember}"
    Then I validate the response has status code 200
    Then Response body should match with "src/test/resources/schemas/trello/organizations/19RemoveAMemberFromAnOrganization.json" json schema

  @regression @negative
  Scenario: Verify the the status code 400 is displayed when a fake organization id is used
    When I send a "DELETE" request to "/organizations/{Org.id}/members/fakeId123WWE"
    Then I validate the response has status code 400
    Then Response body should match with "src/test/resources/schemas/trello/organizations/19RemoveAMemberFromAnOrganization.json" json schema
