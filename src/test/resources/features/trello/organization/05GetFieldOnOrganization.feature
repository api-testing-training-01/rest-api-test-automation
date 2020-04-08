@CreateOrganization @deletedOrganization
Feature: Get field on Organization
  Background:
    Given I use the "trello" service and the "owner" account

  Scenario Outline: Get fields an Organization
    When I send a "GET" request to "/organizations/{Org.id}/<field>"
    Then I validate the response has status code <statusCode>
  Examples:
    |statusCode|field|
    |       404|id|
    |       200|name|
    |       200|displayName|
    |       200|desc|
    |       200|descData|
    |       200|url|
    |       200|website|
    |       200|teamType|
    |       200|logoHash|
    |       200|logoUrl|
    |       200|products|
    |       200|powerUps|
