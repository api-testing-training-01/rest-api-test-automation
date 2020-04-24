@CreateCampaign
Feature: Delete an Campaign
  Background:
    Given I use the "sfdc" service and the "owner" account

  @acceptance @regression
  Scenario: Delete an Campaign
    When I send a "DELETE" request to "/campaign/{Campaign.id}"
    Then I validate the response has status code 204

  @regression @negative
  @DeletedCampaign
  Scenario: Verify the the status code 404 is displayed when a fake organization id is used
    When I send a "DELETE" request to "/campaign/fakeId123WWE"
    Then I validate the response has status code 404
    And I validate the response contains:
      |message       |entity is deleted|
      |errorCode     |ENTITY_IS_DELETED|
