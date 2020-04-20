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
    And I save the request endpoint for deleting
    Then I send a "POST" request to "/boards/{Board.id}/boardPlugins" with json body
    # "56d5e249a98895a9797bebb9" is the id for Custom Fields plugin, this id does not change
        """
        {
        "idPlugin":"56d5e249a98895a9797bebb9"
        }
        """
    Then I validate the response has status code 200

  @cleanData @acceptance @customFields
  Scenario: Get a custom field type "list"
    Given I send a "POST" request to "/customFields" with json body
       """
       {
       "idModel": "{Board.id}",
       "modelType": "board",
       "name": "My Dropdown",
       "pos": "bottom",
       "type": "list"
       }
       """
    And I validate the response has status code 200
    And I save the response as "Custom"
    When I send a "GET" request to "/customFields/{Custom.id}"
    Then I validate the response has status code 200
    And Response body should match with "src/test/resources/schemas/trello/customFields/getOneSchema.json" json schema
    And I validate the response contains:
      | modelType | board       |
      | name      | My Dropdown |
      | type      | list        |

  @cleanData @acceptance @customFields
  Scenario: Get a custom field type "checkbox"
    Given I send a "POST" request to "/customFields" with json body
       """
       {
       "idModel": "{Board.id}",
       "modelType": "board",
       "name": "My checkbox",
       "pos": "bottom",
       "type": "checkbox"
       }
       """
    And I validate the response has status code 200
    And I save the response as "Custom"
    When I send a "GET" request to "/customFields/{Custom.id}"
    Then I validate the response has status code 200
    And Response body should match with "src/test/resources/schemas/trello/customFields/getOneSchema.json" json schema
    And I validate the response contains:
      | modelType | board       |
      | name      | My checkbox |
      | type      | checkbox    |

  @cleanData @acceptance @customFields
  Scenario: Get a custom field type "date"
    Given I send a "POST" request to "/customFields" with json body
       """
       {
       "idModel": "{Board.id}",
       "modelType": "board",
       "name": "My date",
       "pos": "bottom",
       "type": "date"
       }
       """
    And I validate the response has status code 200
    And I save the response as "Custom"
    When I send a "GET" request to "/customFields/{Custom.id}"
    Then I validate the response has status code 200
    And Response body should match with "src/test/resources/schemas/trello/customFields/getOneSchema.json" json schema
    And I validate the response contains:
      | modelType | board   |
      | name      | My date |
      | type      | date    |

  @cleanData @acceptance @customFields
  Scenario: Get a custom field type "number"
    Given I send a "POST" request to "/customFields" with json body
       """
       {
       "idModel": "{Board.id}",
       "modelType": "board",
       "name": "My number",
       "pos": "bottom",
       "type": "number"
       }
       """
    And I validate the response has status code 200
    And I save the response as "Custom"
    When I send a "GET" request to "/customFields/{Custom.id}"
    Then I validate the response has status code 200
    And Response body should match with "src/test/resources/schemas/trello/customFields/getOneSchema.json" json schema
    And I validate the response contains:
      | modelType | board     |
      | name      | My number |
      | type      | number    |

  @cleanData @acceptance @customFields
  Scenario: Get a custom field type "text"
    Given I send a "POST" request to "/customFields" with json body
       """
       {
       "idModel": "{Board.id}",
       "modelType": "board",
       "name": "My text",
       "pos": "bottom",
       "type": "text"
       }
       """
    And I validate the response has status code 200
    And I save the response as "Custom"
    When I send a "GET" request to "/customFields/{Custom.id}"
    Then I validate the response has status code 200
    And Response body should match with "src/test/resources/schemas/trello/customFields/getOneSchema.json" json schema
    And I validate the response contains:
      | modelType | board   |
      | name      | My text |
      | type      | text    |

  @cleanData @acceptance @customFields
  Scenario: Get options of a custom field type "list" empty
    Given I send a "POST" request to "/customFields" with json body
       """
       {
       "idModel": "{Board.id}",
       "modelType": "board",
       "name": "My Dropdown",
       "pos": "bottom",
       "type": "list"
       }
       """
    And I validate the response has status code 200
    And I save the response as "Custom"
    When I send a "GET" request to "/customFields/{Custom.id}/options"
    Then I validate the response has status code 200

  @cleanData @acceptance @customFields
  Scenario: Get options of a custom field type "list"
    Given I send a "POST" request to "/customFields" with json body
       """
       {
       "idModel": "{Board.id}",
       "modelType": "board",
       "name": "My Dropdown",
       "pos": "bottom",
         "options": [
        {
          "color": "blue",
           "value": {"text": "First Option"},
           "pos": 1024
        },
        {
          "color": "red",
          "value": {"text": "Second Option"},
          "pos": 2048
        }
       ],
       "type": "list"
       }
       """
    And I validate the response has status code 200
    And I save the response as "Custom"
    When I send a "GET" request to "/customFields/{Custom.id}/options"
    Then I validate the response has status code 200
    And Response body should match with "src/test/resources/schemas/trello/customFields/getOptionsListSchema.json" json schema

  @cleanData @acceptance @customFields
  Scenario: Get options of a non-custom field type "list"
    Given I send a "POST" request to "/customFields" with json body
       """
       {
       "idModel": "{Board.id}",
       "modelType": "board",
       "name": "My number",
       "pos": "bottom",
       "type": "number"
       }
       """
    And I validate the response has status code 200
    And I save the response as "Custom"
    When I send a "GET" request to "/customFields/{Custom.id}/options"
    Then I validate the response has status code 404
    And Response body should match with "src/test/resources/schemas/trello/customFields/getOptionsErrorSchema.json" json schema


