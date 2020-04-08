@CreateOrganization @deletedOrganization
Feature: Create a new Organization
  Background:
    Given I use the "trello" service and the "owner" account

  Scenario Outline: Validate organization displayName field
    When I send a "PUT" request to "/organizations/{Org.id}" with json body
        """
        {
        "displayName": "<displayName>"
        }
        """
    Then I validate the response has status code <statusCode>
    Examples:
      |statusCode|displayName|
      |       200|my team    |
      |       200|MY TEAM    |
      |       200|My Team 01 |
      |       200|My#Team_02 |
      |       200|M!@#$%^Team|
      |       200|My team x 100 My team x 100 My team x 100 My team x 100 My team x 100 My team x 100 My team x 100 My|
      |       400|My team x 100 My team x 100 My team x 100 My team x 100 My team x 100 My team x 100 My team x 100 My+1|
      |       400|           |


  Scenario Outline: Validate organization name field
    When I send a "PUT" request to "/organizations/{Org.id}" with json body
        """
        {
        "name": "<name>"
        }
        """
    Then I validate the response has status code <statusCode>
    Examples:
      |statusCode|name|
      |       400|my_team    |
      |       400|MY_TEAM    |
      |       200|my_team_01 |
      |       400|my#team_02 |
      |       400|           |
      |       400|My         |
      |       200|12346_78   |
      |       400|!@#$%      |


  Scenario Outline: Validate organization type field
    When I send a "PUT" request to "/organizations/{Org.id}" with json body
        """
        {
        "teamType": "<teamType>"
        }
        """
    Then I validate the response has status code <statusCode>
    Examples:
      |statusCode|teamType|
      |       200|business|
      |       200|education|
      |       200|engineering-it|
      |       200|project management|
      |       200|marketing|
      |       200|sales|
      |       200|other|
      |       400|fake type|
      |       400|        |
      |       400|       1|
      |       400|Business|
      |       400|Education|
      |       400|Engineering-It|
      |       400|Project Management|
      |       400|Marketing|
      |       400|Sales|
      |       400|Other|

  Scenario Outline: Validate organization Description field
    When I send a "PUT" request to "/organizations/{Org.id}" with json body
        """
        {
        "desc": "<desc>"
        }
        """
    Then I validate the response has status code <statusCode>
    Examples:
      |statusCode|desc|
      |       200|          |
      |       200|Hello Team|
      |       200|!@#$%^&|
      |       200|12345689|
      |       200|123QWERTY|
      |       200|123!@#QWERT|
      |       200|Hello new team Hello new team Hello new team Hello new team Hello new team|

  Scenario Outline: Validate organization website field
    When I send a "PUT" request to "/organizations/{Org.id}" with json body
        """
        {
        "website": "<website>"
        }
        """
    Then I validate the response has status code <statusCode>
    Examples:
      |statusCode|website   |
      |       200|          |
      |       200|https://www.youtube.com/|
      |       400|!@#$%^&|
      |       400|12345689|
      |       400|123QWERTY|
      |       400|123!@#QWERT|
      |       400|Hello new team Hello new team Hello new team Hello new team Hello new team|

  Scenario Outline: Validate organization prefs/permissionLevel field
    When I send a "PUT" request to "/organizations/{Org.id}" with json body
        """
        {
        "prefs/permissionLevel": "<prefs/permissionLevel>"
        }
        """
    Then I validate the response has status code <statusCode>
    Examples:
      |statusCode|prefs/permissionLevel|
      |       400|          |
      |       200|public    |
      |       200|private   |
      |       400|1         |
      |       400|Public    |
      |       400|PRIVATE   |
      |       400|Hello new team Hello new team Hello new team Hello new team Hello new team|
