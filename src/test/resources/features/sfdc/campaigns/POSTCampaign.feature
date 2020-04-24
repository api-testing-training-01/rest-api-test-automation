@cleanData
Feature: Creates campaigns

  @acceptance @regression
  Scenario Outline: Create basic campaign
    Given I use the "sfdc" service and the "owner" account
    When I send a "POST" request to "/campaign" with json body
      """
      {
	    "name":"<name>"
      }
      """
    Then I validate the response has status code <statusCode>
    And I save the request endpoint for deleting
    And Response body should match with "src/test/resources/schemas/sfdc/campaigns/POSTCampaigns.json" json schema
    And I validate the response contains:
      | success      | true      |
    Examples:
    |statusCode|name|
    |       201|my campaigns    |
    |       201|MY CAMPAIGNS    |
    |       201|my campaigns 01 |
    |       201|My#Campaigns_02 |
    |       201|M!@#$%^campaigns|
    |       201|my campaigns 01my campaigns 01my campaigns 01my campaigns 01my campaigns 01my c|
    |       400|my campaigns 01my campaigns 01my campaigns 01my campaigns 01my campaigns 01my campaigns|
    |       400|           |

  @acceptance @regression
  Scenario Outline: Create campaign with description
    Given I use the "sfdc" service and the "owner" account
    When I send a "POST" request to "/campaign" with json body
      """
      {
	    "name":"My Campaign",
	    "description":"<description>"
      }
      """
    Then I validate the response has status code <statusCode>
    And I save the request endpoint for deleting
    And Response body should match with "src/test/resources/schemas/sfdc/campaigns/POSTCampaigns.json" json schema
    And I validate the response contains:
      | success      | true      |
    Examples:
      |statusCode|description|
      |       201|my description    |
      |       201|MY DESCRIPTION    |
      |       201|my description 01 |
      |       201|My#description_02 |
      |       201|M!@#$%^description|
      |       201|my description 01 my description 01 my description 01 my description 01 my desc|
#      |       400|my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my descmy description 01 my description 01 my description 01 my description 01 my descmy description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my descmy description 01 my description 01 my description 01 my description 01 my descmy description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my descmy description 01 my description 01 my description 01 my description 01 my descmy description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my descmy description 01 my description 01 my description 01 my description 01 my descmy description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my descmy description 01 my description 01 my description 01 my description 01 my descmy description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my descmy description 01 my description 01 my description 01 my description 01 my descmy description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my descmy description 01 my description 01 my description 01 my description 01 my descmy description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my descmy description 01 my description 01 my description 01 my description 01 my descmy description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my descmy description 01 my description 01 my description 01 my description 01 my descmy description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my descmy description 01 my description 01 my description 01 my description 01 my descmy description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my descmy description 01 my description 01 my description 01 my description 01 my descmy description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my descmy description 01 my description 01 my description 01 my description 01 my descmy description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my descmy description 01 my description 01 my description 01 my description 01 my descmy description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my descmy description 01 my description 01 my description 01 my description 01 my descmy description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my descmy description 01 my description 01 my description 01 my description 01 my descmy description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my descmy description 01 my description 01 my description 01 my description 01 my descmy description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my descmy description 01 my description 01 my description 01 my description 01 my descmy description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my descmy description 01 my description 01 my description 01 my description 01 my descmy description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my descmy description 01 my description 01 my description 01 my description 01 my descmy description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my descmy description 01 my description 01 my description 01 my description 01 my descmy description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my descmy description 01 my description 01 my description 01 my description 01 my descmy description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my descmy description 01 my description 01 my description 01 my description 01 my descmy description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my descmy description 01 my description 01 my description 01 my description 01 my descmy description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my descmy description 01 my description 01 my description 01 my description 01 my desc|
      |       201|           |

  @acceptance @regression
  Scenario Outline: Create active/inactive campaign
    Given I use the "sfdc" service and the "owner" account
    When I send a "POST" request to "/campaign" with json body
      """
      {
	    "name":"my api campaing1000",
	    "description":"my description",
	    "isActive": <isActive>
      }
      """
    Then I validate the response has status code <statusCode>
    And I save the request endpoint for deleting
    And Response body should match with "src/test/resources/schemas/sfdc/campaigns/POSTCampaigns.json" json schema
    And I validate the response contains:
      | success      | true      |
    Examples:
      |statusCode|isActive|
      |       201|true    |
      |       201|false   |
      |       400|hello   |


  @acceptance @regression
  Scenario Outline: Create all types of campaigns
    Given I use the "sfdc" service and the "owner" account
    When I send a "POST" request to "/campaign" with json body
      """
      {
	    "name":"my api campaing1000",
	    "description":"my description",
	    "isActive": true,
	    "type": "<type>"
      }
      """
    Then I validate the response has status code <statusCode>
    And I save the request endpoint for deleting
    And Response body should match with "src/test/resources/schemas/sfdc/campaigns/POSTCampaigns.json" json schema
    And I validate the response contains:
      | success      | true      |
    Examples:
      |statusCode|type    |
      |       201|--None--|
      |       201|Conference|
      |       201|Webinar|
      |       201|Trade Show|
      |       201|Public Relations|
      |       201|Partners |
      |       201|Referral Program|
      |       201|Advertisement|
      |       201|Banner Ads |
      |       201|Direct Mail|
      |       201|Email|
      |       201|Telemarketing|
      |       201|Other|

  @acceptance @regression
  Scenario Outline: Create all status of campaigns
    Given I use the "sfdc" service and the "owner" account
    When I send a "POST" request to "/campaign" with json body
      """
      {
	    "name":"my api campaing1000",
	    "description":"my description",
	    "isActive": true,
	    "type": "Conference",
	    "status":"<status>"
      }
      """
    Then I validate the response has status code <statusCode>
    And I save the request endpoint for deleting
    And Response body should match with "src/test/resources/schemas/sfdc/campaigns/POSTCampaigns.json" json schema
    And I validate the response contains:
      | success      | true      |
    Examples:
      |statusCode|status    |
      |       201|--None--  |
      |       201|Planned   |
      |       201|In Progress|
      |       201|Completed |
      |       201|Aborted |

  @acceptance @regression
  Scenario Outline: Create campaigns with start date and end date
    Given I use the "sfdc" service and the "owner" account
    When I send a "POST" request to "/campaign" with json body
      """
      {
	    "name":"my api campaing1000",
	    "description":"my description",
	    "isActive": true,
	    "type": "Conference",
	    "status":"Planned",
	    "startDate":"<startDate>",
	    "endDate":"<endDate>"
      }
      """
    Then I validate the response has status code <statusCode>
    And I save the request endpoint for deleting
    And Response body should match with "src/test/resources/schemas/sfdc/campaigns/POSTCampaigns.json" json schema
    And I validate the response contains:
      | success      | true      |
    Examples:
      |statusCode|startDate    |endDate     |
      |       201|2020-04-22   |2020-04-22  |
      |       400|             |2020-04-22  |
      |       400|2020-04-22   |            |
      |       400|             |            |
      |       400|2020-04-22ss |2020-04-22  |
      |       400|2020-04-22   |2020-04-22ss|
      |       400|2020.04.22   |2020-04-22  |
      |       400|2020/04/22   |2020-04-22  |
      |       400|2020-04-22   |2020.04.22  |
      |       400|2020-04-22   |2020/04/22  |

  @acceptance @regression
  Scenario Outline: Create campaigns with expected revenue
    Given I use the "sfdc" service and the "owner" account
    When I send a "POST" request to "/campaign" with json body
      """
      {
	    "name":"my api campaing1000",
	    "description":"my description",
	    "isActive": true,
	    "type": "Conference",
	    "status":"Planned",
	    "startDate":"2020-04-22",
	    "endDate":"2020-04-22",
	    "expectedRevenue": "<expectedRevenue>"
      }
      """
    Then I validate the response has status code <statusCode>
    And I save the request endpoint for deleting
    And Response body should match with "src/test/resources/schemas/sfdc/campaigns/POSTCampaigns.json" json schema
    And I validate the response contains:
      | success      | true      |
    Examples:
      |statusCode|expectedRevenue|
      |       201|50             |
      |       201|1000           |
      |       201|1234567890123456|
      |       201|                |
      |       400|12345678901234567890|
      |       400|One hundred    |

  @acceptance @regression
  Scenario Outline: Create campaigns with budgeted cost
    Given I use the "sfdc" service and the "owner" account
    When I send a "POST" request to "/campaign" with json body
      """
      {
	    "name":"my api campaing1000",
	    "description":"my description",
	    "isActive": true,
	    "type": "Conference",
	    "status":"Planned",
	    "startDate":"2020-04-22",
	    "endDate":"2020-04-22",
	    "expectedRevenue": "9999999",
	    "budgetedCost": "<BudgetedCost>"
      }
      """
    Then I validate the response has status code <statusCode>
    And I save the request endpoint for deleting
    And Response body should match with "src/test/resources/schemas/sfdc/campaigns/POSTCampaigns.json" json schema
    And I validate the response contains:
      | success      | true      |
    Examples:
      |statusCode|BudgetedCost   |
      |       201|50             |
      |       201|1000           |
      |       201|1234567890123456|
      |       201|                |
      |       400|12345678901234567890|
      |       400|One hundred    |

  @acceptance @regression
  Scenario Outline: Create campaigns with actual cost
    Given I use the "sfdc" service and the "owner" account
    When I send a "POST" request to "/campaign" with json body
      """
      {
	    "name":"my api campaing1000",
	    "description":"my description",
	    "isActive": true,
	    "type": "Conference",
	    "status":"Planned",
	    "startDate":"2020-04-22",
	    "endDate":"2020-04-22",
	    "expectedRevenue": "9999999",
	    "budgetedCost": "999999",
	    "actualCost":"<ActualCost>"
      }
      """
    Then I validate the response has status code <statusCode>
    And I save the request endpoint for deleting
    And Response body should match with "src/test/resources/schemas/sfdc/campaigns/POSTCampaigns.json" json schema
    And I validate the response contains:
      | success      | true      |
    Examples:
      |statusCode|ActualCost     |
      |       201|50             |
      |       201|1000           |
      |       201|1234567890123456|
      |       201|                |
      |       400|12345678901234567890|
      |       400|One hundred    |

  @acceptance @regression
  Scenario Outline: Create campaigns with expected response(%)
    Given I use the "sfdc" service and the "owner" account
    When I send a "POST" request to "/campaign" with json body
      """
      {
	    "name":"my api campaing",
	    "description":"my description",
	    "isActive": true,
	    "type": "Conference",
	    "status":"Planned",
	    "startDate":"2020-04-22",
	    "endDate":"2020-04-22",
	    "expectedRevenue": "9999999",
	    "budgetedCost": "999999",
	    "actualCost":"999999",
	    "expectedResponse":"<expectedResponse>"
      }
      """
    Then I validate the response has status code <statusCode>
    And I save the request endpoint for deleting
    And Response body should match with "src/test/resources/schemas/sfdc/campaigns/POSTCampaigns.json" json schema
    And I validate the response contains:
      | success      | true      |
    Examples:
      |statusCode|expectedResponse|
      |       201|50              |
      |       201|0.48            |
      |       201|1.23456789012345|
      |       201|                |
      |       400|12345678901234567890|
      |       400|One hundred     |
