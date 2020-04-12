@CreateOrganization @deletedOrganization
Feature: Update an organization's members
  Background:
    Given I use the "trello" service and the "owner" account

  Scenario Outline: Get an Organization
    When I send a "PUT" request to "/organizations/{Org.id}/members" with json body
    """
    {
      "email":"<email>",
      "fullName":"<fullName>",
      "type":"<type>"
    }
    """
    Then I validate the response has status code <statusCode>
    Examples:
      |statusCode|email                        |fullName      |type  |
      |       200|trello.test.01@mailinator.com|trello.test.01|normal|
      |       403|trello.test.02@mailinator.com|trello.test.02| admin|
      |       400|trello.test.03@mailinator.com|trello.test.03|      |
      |       200|trello.test.04@mailinator.com|              |normal|
      |       400|                             |trello.test.05|normal|
      |       400|trello.test.06@mailinator.com|trello.test.06|NORMAL|
      |       400|trello.test.06@mailinator.com|trello.test.06| ADMIN|
      |       400|trello.test.06@mailinator.com|trello.test.06|     1|

  Scenario: Verify the the status code 404 is displayed when a fake organization id is used
    When I send a "PUT" request to "/organizations/fakeId123WWE/members" with json body
    """
    {
      "email":"trello.test.0@mailinator.com",
      "fullName":"trello.test.0",
      "type":"admin"
    }
    """
    Then I validate the response has status code 404