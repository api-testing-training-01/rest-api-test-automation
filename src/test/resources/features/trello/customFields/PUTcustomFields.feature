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
  Scenario: Update a custom field
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
    Then I validate the response has status code 200
    And I save the response as "Custom"
    When I send a "PUT" request to "/customFields/{Custom.id}" with json body
       """
       {
       "name": "My Dropdown edited"
       }
       """
    And Response body should match with "src/test/resources/schemas/trello/customFields/putSchema.json" json schema
    And I validate the response contains:
      | name      | My Dropdown edited |
