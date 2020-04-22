@CreateCampaign @DeletedCampaign
Feature: Get an Campaign
  Background:
    Given I use the "sfdc" service and the "owner" account

  @acceptance @regression
  Scenario: Get an Campaign
    When I send a "GET" request to "/campaign/{Campaign.id}"
    Then I validate the response has status code 200
    Then Response body should match with "src/test/resources/schemas/sfdc/campaigns/GETCampaigns.json" json schema
    And I validate the response contains:
        |Name            |my api campaing|
        |Description     |my description|
        |IsActive        |true|
        |Type            |Conference|
        |Status          |Planned|
        |StartDate       |2020-04-22|
        |EndDate         |2020-04-22|

  @regression @negative
  Scenario: Verify the the status code 404 is displayed when a fake Campaign Id is used
    When I send a "GET" request to "/campaign/fakeId123WWE"
    Then I validate the response has status code 404
    Then Response body should match with "src/test/resources/schemas/sfdc/campaigns/GETCampaigns.json" json schema
