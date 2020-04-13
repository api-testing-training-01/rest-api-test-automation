@cleanData
Feature: Create a new Organization
  Background:
    Given I use the "trello" service and the "owner" account

  @acceptance @regression
  Scenario: Create an organization
    When I send a "POST" request to "/organizations" with json body
        """
        {
        "displayName": "My team",
        "teamType":"sales",
        "desc":"My team description"
        }
        """
    Then I validate the response has status code 200
    Then I save the request endpoint for deleting
    Then Response body should match with "src/test/resources/schemas/trello/organizations/01CreateANewOrganization.json" json schema
    And I validate the response contains:
        | displayName  | My team            |
        | teamType     | sales              |
        | desc         | My team description|

  @regression
  Scenario Outline: Validate organization displayName field
    When I send a "POST" request to "/organizations" with json body
        """
        {
        "displayName": "<displayName>",
        "teamType":"sales",
        "desc":"My team description"
        }
        """
    Then I validate the response has status code <statusCode>
    Then I save the request endpoint for deleting
    Then Response body should match with "src/test/resources/schemas/trello/organizations/01CreateANewOrganization.json" json schema
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

  @regression
  Scenario Outline: Validate organization name field
    When I send a "POST" request to "/organizations" with json body
        """
        {
        "displayName": "Team01",
        "name": "<name>",
        "teamType":"sales",
        "desc":"My team description"
        }
        """
    Then I validate the response has status code <statusCode>
    Then I save the request endpoint for deleting
    Then Response body should match with "src/test/resources/schemas/trello/organizations/01CreateANewOrganization.json" json schema
    Examples:
      |statusCode|name|
      |       200|my_team    |
      |       200|MY_TEAM    |
      |       200|my_team_01 |
      |       200|my#team_02 |
      |       200|           |
      |       200|My         |
      |       200|12346_78   |
      |       200|!@#$%      |

  @regression
  Scenario Outline: Validate organization type field
    When I send a "POST" request to "/organizations" with json body
        """
        {
        "displayName": "<displayName>",
        "name": "<displayName>",
        "teamType":"<teamType>",
        "desc":"My team description"
        }
        """
    Then I validate the response has status code <statusCode>
    Then I save the request endpoint for deleting
    Then Response body should match with "src/test/resources/schemas/trello/organizations/01CreateANewOrganization.json" json schema
    Examples:
      |statusCode|displayName|teamType|
      |       200|my_team00  |business|
      |       200|my_team01  |education|
      |       200|my_team02  |engineering-it|
      |       200|my_team03  |project management|
      |       200|my_team04  |marketing|
      |       200|my_team05  |sales|
      |       200|my_team06  |other|
      |       400|my_team07  |fake type|
      |       400|my_team08  |        |
      |       400|my_team09  |       1|
      |       400|my_team10  |Business|
      |       400|my_team11  |Education|
      |       400|my_team12  |Engineering-It|
      |       400|my_team13  |Project Management|
      |       400|my_team14  |Marketing|
      |       400|my_team15  |Sales|
      |       400|my_team16  |Other|

  @regression
  Scenario Outline: Validate organization Description field
    When I send a "POST" request to "/organizations" with json body
        """
        {
        "displayName": "<displayName>",
        "name": "<displayName>",
        "teamType":"<teamType>",
        "desc":"<desc>"
        }
        """
    Then I validate the response has status code <statusCode>
    Then I save the request endpoint for deleting
    Then Response body should match with "src/test/resources/schemas/trello/organizations/01CreateANewOrganization.json" json schema
    Examples:
      |statusCode|displayName|teamType          |desc|
      |       200|my_team01  |business          |           |
      |       200|my_team02  |education         |Hello Team|
      |       200|my_team03  |engineering-it    |!@#$%^&|
      |       200|my_team04  |project management|12345689|
      |       200|my_team05  |marketing         |123QWERTY|
      |       200|my_team06  |sales             |123!@#QWERT|

  @regression
  @CreateOrganization @deletedOrganization
  Scenario: Verify that it is not possible to create a organization with the same name
    When I send a "POST" request to "/organizations" with json body
        """
        {
        "displayName": "my_team_a",
        "name": "my_team",
        "teamType":"sales",
        "desc":"My team description"
        }
        """
    Then I validate the response has status code 200
    Then I save the request endpoint for deleting
    Then Response body should match with "src/test/resources/schemas/trello/organizations/01CreateANewOrganization.json" json schema

  @regression
  @CreateOrganization @deletedOrganization
  Scenario: Verify that it is not possible to create a organization with the same displayName
    When I send a "POST" request to "/organizations" with json body
        """
        {
        "displayName": "my_team",
        "name": "my_team_a",
        "teamType":"sales",
        "desc":"My team description"
        }
        """
    Then I validate the response has status code 200
    Then I save the request endpoint for deleting
    Then Response body should match with "src/test/resources/schemas/trello/organizations/01CreateANewOrganization.json" json schema

