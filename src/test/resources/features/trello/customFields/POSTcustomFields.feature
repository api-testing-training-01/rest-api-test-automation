Feature: Customs Fields

  Background:
    Given I use the "trello" service and the "owner" account
    And I send a "POST" request to "/boards" with json body
        """
        {
        "name": "Testing"
        }
        """
    And I save the response as "Board"
    Then I send a "POST" request to "/boards/{Board.id}/boardPlugins" with json body
    # "56d5e249a98895a9797bebb9" is the id for Custom Fields plugin, this id does not change
        """
        {
        "idPlugin":"56d5e249a98895a9797bebb9"
        }
        """
    And I validate the response has status code 200
    And I save the response as "Plugin"
    And I save the request endpoint for deleting

  @cleanData @acceptance @customFields
  Scenario: Create a custom field when Power up is disabled
    Given I send a "DELETE" request to "/boards/{Board.id}/boardPlugins/{Plugin.id}"
    Then I validate the response has status code 200
    When I send a "POST" request to "/customFields" with json body
       """
       {
       "idModel": "{Board.id}",
       "modelType": "board",
       "name": "My Dropdown",
       "pos": "bottom",
       "type": "list"
       }
       """
    Then I validate the response has status code 403

  @cleanData @acceptance @customFields
  Scenario: Create a custom field type "list"
    When I send a "POST" request to "/customFields" with json body
       """
       {
       "idModel": "{Board.id}",
       "modelType": "board",
       "name": "My Dropdown",
       "pos": "bottom",
       "type": "list"
       }
       """
    Then I validate the response has status code 200
    And Response body should match with "src/test/resources/schemas/trello/customFields/postListSchema.json" json schema
    And I validate the response contains:
      | modelType | board       |
      | name      | My Dropdown |
      | type      | list        |

  @cleanData @acceptance @customFields
  Scenario: Create a custom field type "checkbox"
    When I send a "POST" request to "/customFields" with json body
       """
       {
       "idModel": "{Board.id}",
       "modelType": "board",
       "name": "My checkbox",
       "pos": "bottom",
       "type": "checkbox"
       }
       """
    Then I validate the response has status code 200
    And Response body should match with "src/test/resources/schemas/trello/customFields/postCheckboxSchema.json" json schema
    And I validate the response contains:
      | modelType | board       |
      | name      | My checkbox |
      | type      | checkbox    |

  @cleanData @acceptance @customFields
  Scenario: Create a custom field type "date"
    When I send a "POST" request to "/customFields" with json body
       """
       {
       "idModel": "{Board.id}",
       "modelType": "board",
       "name": "My date",
       "pos": "bottom",
       "type": "date"
       }
       """
    Then I validate the response has status code 200
    And Response body should match with "src/test/resources/schemas/trello/customFields/postDateSchema.json" json schema
    And I validate the response contains:
      | modelType | board   |
      | name      | My date |
      | type      | date    |

  @cleanData @acceptance @customFields
  Scenario: Create a custom field type "number"
    When I send a "POST" request to "/customFields" with json body
       """
       {
       "idModel": "{Board.id}",
       "modelType": "board",
       "name": "My number",
       "pos": "bottom",
       "type": "number"
       }
       """
    Then I validate the response has status code 200
    And Response body should match with "src/test/resources/schemas/trello/customFields/postNumberSchema.json" json schema
    And I validate the response contains:
      | modelType | board     |
      | name      | My number |
      | type      | number    |

  @cleanData @acceptance @customFields
  Scenario: Create a custom field type "text"
    When I send a "POST" request to "/customFields" with json body
       """
       {
       "idModel": "{Board.id}",
       "modelType": "board",
       "name": "My text",
       "pos": "bottom",
       "type": "text"
       }
       """
    Then I validate the response has status code 200
    And Response body should match with "src/test/resources/schemas/trello/customFields/postTextSchema.json" json schema
    And I validate the response contains:
      | modelType | board   |
      | name      | My text |
      | type      | text    |