@CreateOrganization @deletedOrganization
Feature: Get boards in an organization
  Background:
    Given I use the "trello" service and the "owner" account

  Scenario: Get an Organization
    When I send a "GET" request to "/organizations/{Org.id}/boards"
    Then I validate the response has status code 200

  Scenario: Verify the the status code 404 is displayed when a fake organization id is used
    When I send a "GET" request to "/organizations/fakeId123WWE/boards"
    Then I validate the response has status code 404
