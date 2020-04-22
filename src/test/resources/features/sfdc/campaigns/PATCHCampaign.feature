@CreateCampaign @DeletedCampaign
Feature: Creates campaigns

  @acceptance @regression
  Scenario Outline: Update name
    Given I use the "sfdc" service and the "owner" account
    When I send a "PATCH" request to "/campaign/{Campaign.id}" with json body
      """
      {
	    "name":"<name>"
      }
      """
    Then I validate the response has status code <statusCode>
    Examples:
      |statusCode|name|
      |       204|my campaigns    |
      |       204|MY CAMPAIGNS    |
      |       204|my campaigns 01 |
      |       204|My#Campaigns_02 |
      |       204|M!@#$%^campaigns|
      |       204|my campaigns 01my campaigns 01my campaigns 01my campaigns 01my campaigns 01my c|
      |       400|my campaigns 01my campaigns 01my campaigns 01my campaigns 01my campaigns 01my campaigns|
      |       400|           |

  @acceptance @regression
  Scenario Outline: Update description
    Given I use the "sfdc" service and the "owner" account
    When I send a "PATCH" request to "/campaign/{Campaign.id}" with json body
      """
      {
	    "description":"<description>"
      }
      """
    Then I validate the response has status code <statusCode>
    Examples:
      |statusCode|description|
      |       204|my description    |
      |       204|MY DESCRIPTION    |
      |       204|my description 01 |
      |       204|My#description_02 |
      |       204|M!@#$%^description|
      |       204|my description 01 my description 01 my description 01 my description 01 my desc|
#      |       400|my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my descmy description 01 my description 01 my description 01 my description 01 my descmy description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my descmy description 01 my description 01 my description 01 my description 01 my descmy description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my descmy description 01 my description 01 my description 01 my description 01 my descmy description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my descmy description 01 my description 01 my description 01 my description 01 my descmy description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my descmy description 01 my description 01 my description 01 my description 01 my descmy description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my descmy description 01 my description 01 my description 01 my description 01 my descmy description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my descmy description 01 my description 01 my description 01 my description 01 my descmy description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my descmy description 01 my description 01 my description 01 my description 01 my descmy description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my descmy description 01 my description 01 my description 01 my description 01 my descmy description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my descmy description 01 my description 01 my description 01 my description 01 my descmy description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my descmy description 01 my description 01 my description 01 my description 01 my descmy description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my descmy description 01 my description 01 my description 01 my description 01 my descmy description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my descmy description 01 my description 01 my description 01 my description 01 my descmy description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my descmy description 01 my description 01 my description 01 my description 01 my descmy description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my descmy description 01 my description 01 my description 01 my description 01 my descmy description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my descmy description 01 my description 01 my description 01 my description 01 my descmy description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my descmy description 01 my description 01 my description 01 my description 01 my descmy description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my descmy description 01 my description 01 my description 01 my description 01 my descmy description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my descmy description 01 my description 01 my description 01 my description 01 my descmy description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my descmy description 01 my description 01 my description 01 my description 01 my descmy description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my descmy description 01 my description 01 my description 01 my description 01 my descmy description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my descmy description 01 my description 01 my description 01 my description 01 my descmy description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my descmy description 01 my description 01 my description 01 my description 01 my descmy description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my description 01 my descmy description 01 my description 01 my description 01 my description 01 my desc|
      |       204|                  |

  @acceptance @regression
  Scenario Outline: Update campaign as active/inactive
    Given I use the "sfdc" service and the "owner" account
    When I send a "PATCH" request to "/campaign/{Campaign.id}" with json body
      """
      {
	    "isActive": <isActive>
      }
      """
    Then I validate the response has status code <statusCode>
    Examples:
      |statusCode|isActive|
      |       204|true    |
      |       204|false   |
      |       400|hello   |


  @acceptance @regression
  Scenario Outline: Update type
    Given I use the "sfdc" service and the "owner" account
    When I send a "PATCH" request to "/campaign/{Campaign.id}" with json body
      """
      {
	    "type": "<type>"
      }
      """
    Then I validate the response has status code <statusCode>
    Examples:
      |statusCode|type    |
      |       204|--None--|
      |       204|Conference|
      |       204|Webinar|
      |       204|Trade Show|
      |       204|Public Relations|
      |       204|Partners |
      |       204|Referral Program|
      |       204|Advertisement|
      |       204|Banner Ads |
      |       204|Direct Mail|
      |       204|Email|
      |       204|Telemarketing|
      |       204|Other|

  @acceptance @regression
  Scenario Outline: Update status
    Given I use the "sfdc" service and the "owner" account
    When I send a "PATCH" request to "/campaign/{Campaign.id}" with json body
      """
      {
	    "status":"<status>"
      }
      """
    Then I validate the response has status code <statusCode>
    Examples:
      |statusCode|status    |
      |       204|--None--  |
      |       204|Planned   |
      |       204|In Progress|
      |       204|Completed |
      |       204|Aborted |

  @acceptance @regression
  Scenario Outline: Update start date and end date
    Given I use the "sfdc" service and the "owner" account
    When I send a "PATCH" request to "/campaign/{Campaign.id}" with json body
      """
      {
	    "startDate":"<startDate>",
	    "endDate":"<endDate>"
      }
      """
    Then I validate the response has status code <statusCode>
    Examples:
      |statusCode|startDate    |endDate     |
      |       204|2021-04-22   |2022-04-22  |
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
  Scenario Outline: Update expected revenue
    Given I use the "sfdc" service and the "owner" account
    When I send a "PATCH" request to "/campaign/{Campaign.id}" with json body
      """
      {
	    "expectedRevenue": "<expectedRevenue>"
      }
      """
    Then I validate the response has status code <statusCode>
    Examples:
      |statusCode|expectedRevenue|
      |       204|50             |
      |       204|1000           |
      |       204|1234567890123456|
      |       204|                |
      |       400|12345678901234567890|
      |       400|One hundred    |

  @acceptance @regression
  Scenario Outline: Update budgeted cost
    Given I use the "sfdc" service and the "owner" account
    When I send a "PATCH" request to "/campaign/{Campaign.id}" with json body
      """
      {
	    "budgetedCost": "<BudgetedCost>"
      }
      """
    Then I validate the response has status code <statusCode>
    Examples:
      |statusCode|BudgetedCost   |
      |       204|50             |
      |       204|1000           |
      |       204|1234567890123456|
      |       204|                |
      |       400|12345678901234567890|
      |       400|One hundred    |

  @acceptance @regression
  Scenario Outline: Update actual cost
    Given I use the "sfdc" service and the "owner" account
    When I send a "PATCH" request to "/campaign/{Campaign.id}" with json body
      """
      {
	    "actualCost":"<ActualCost>"
      }
      """
    Then I validate the response has status code <statusCode>
    Examples:
      |statusCode|ActualCost     |
      |       204|50             |
      |       204|1000           |
      |       204|1234567890123456|
      |       204|                |
      |       400|12345678901234567890|
      |       400|One hundred    |

  @acceptance @regression
  Scenario Outline: Update expected response(%)
    Given I use the "sfdc" service and the "owner" account
    When I send a "PATCH" request to "/campaign/{Campaign.id}" with json body
      """
      {
	    "expectedResponse":"<expectedResponse>"
      }
      """
    Then I validate the response has status code <statusCode>
     Examples:
      |statusCode|expectedResponse|
      |       204|50              |
      |       204|0.48            |
      |       204|1.23456789012345|
      |       204|                |
      |       400|12345678901234567890|
      |       400|One hundred     |
