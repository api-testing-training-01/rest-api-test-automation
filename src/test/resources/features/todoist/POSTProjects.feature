Feature: Todoist Projects

  @cleanData @acceptance
  Scenario: Todoist POST Project
    Given I use the "todoist" service and the "owner" account
    When I send a "POST" request to "/projects" with datatable
      |name|Test_FV_02|
    And I save the request endpoint for deleting
    Then I validate the response has status code 200
    And Response body should match with "src/test/resources/schemas/todoist/postSchema.json" json schema
    And I validate the response contains:
      | kind             | project    |
      | name             | Test_FV_02 |

  @cleanData @negative
  Scenario: Todoist POST Project, name with especial characters
    Given I use the "todoist" service and the "owner" account
    When I send a "POST" request to "/projects" with datatable
      |name|Test_FV_03_<_>_-_#_@_$|
    And I save the request endpoint for deleting
    Then I validate the response has status code 200
    And Response body should match with "src/test/resources/schemas/todoist/postSchema.json" json schema
    And I validate the response contains:
      | kind             | project    |
      | name             | Test_FV_03_____-_____$ |


  @regresion
  Scenario: Todoist POST Project CRUD
    Given I use the "todoist" service and the "owner" account
    When I send a "POST" request to "/projects" with datatable
      |name|Test_FV_02|
    And I validate the response has status code 200
    And Response body should match with "src/test/resources/schemas/todoist/postSchema.json" json schema
    And I validate the response contains:
      | kind             | project    |
      | name             | Test_FV_02 |
    And I send a "GET" request to "/projects/{LAST_RESPONSE.id}"
    And I validate the response has status code 200
    #And I use the "todoist" service and the "owner" account
#    When I send a "POST" request to "/projects/{LAST_RESPONSE.id}" with datatable
#      |name|Test_FV_name_updated|
#    Then I validate the response has status code 204
#    And I send a "GET" request to "/projects/{LAST_RESPONSE.id}"
#    And I validate the response contains:
#      | kind             | project              |
#      | name             | Test_FV_name_updated |
    And I send a "DELETE" request to "/projects/{LAST_RESPONSE.id}"
    Then I validate the response has status code 204