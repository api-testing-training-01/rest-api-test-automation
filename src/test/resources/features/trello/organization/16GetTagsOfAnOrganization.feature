@CreateOrganization @deletedOrganization
Feature: Get Tags of an Organization
  Background:
    Given I use the "trello" service and the "owner" account

  Scenario: Get an Organization
    When I send a "GET" request to "/organizations/{Org.id}/tags"
    Then I validate the response has status code 200

  Scenario: Verify the the status code 404 is displayed when a fake organization id is used
    When I send a "GET" request to "/organizations/fakeId123WWE/tags"
    Then I validate the response has status code 404