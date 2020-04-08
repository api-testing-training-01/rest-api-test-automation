Feature: Todoist Projects

#  Background:
#    Given I use the "todoist" service and the "owner" account
#    And I send a "POST" request to "/projects" with datatable
#      |name|Test_FV_02|
#    And I save the request endpoint for deleting
#  @cleanData @acceptance
#  Scenario: Todoist PUT Project
#    And I use the "todoist" service and the "owner" account
#    When I send a "POST" request to "/projects/{LAST_RESPONSE.id}" with datatable
#      |name|Test_FV_name_updated|
#    Then I validate the response has status code 204
#    And I send a "GET" request to "/projects/{LAST_RESPONSE.id}"
#    And I validate the response contains:
#      | kind             | project              |
#      | name             | Test_FV_name_updated |

#  Background:
#    Given I use the "todoist" service and the "owner" account
#    And I send a "POST" request to "/projects" with datatable
#      |name|Test_FV_02|
#    And I save the request endpoint for deleting
#  @cleanData @acceptance
#  Scenario: Todoist PUT Project
#    And I use the "todoist" service and the "owner" account
#    When I send a "POST" request to "/projects/{LAST_RESPONSE.id}" with json body
#    """
#    {
#    "name": "Test_FV_name_updated"
#    }
#    """
#    Then I validate the response has status code 204
#    And I send a "GET" request to "/projects/{LAST_RESPONSE.id}"
#    And I validate the response contains:
#      | kind             | project              |
#      | name             | Test_FV_name_updated |