@CreateOrganization @CreateMemberInAnOrganization @deletedOrganization
Feature: Get a membership of an organization
  Background:
    Given I use the "trello" service and the "owner" account

  @acceptance @regression
  Scenario: Get an Organization
    When I send a "GET" request to "/organizations/{Org.id}/memberships/{Member.memberships[1].id}"
    Then I validate the response has status code 200
    Then Response body should match with "src/test/resources/schemas/trello/organizations/14GetAMembershipOfAnOrganization.json" json schema

  @regression @negative
  Scenario: Verify the the status code 400 is displayed when a fake organization id is used
    When I send a "GET" request to "/organizations/{Org.id}/memberships/fakeId123WWE"
    Then I validate the response has status code 400
    Then Response body should match with "src/test/resources/schemas/trello/organizations/14GetAMembershipOfAnOrganization.json" json schema
