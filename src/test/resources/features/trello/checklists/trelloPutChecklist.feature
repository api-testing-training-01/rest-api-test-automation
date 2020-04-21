Feature: Checklist

  Background:
    Given I use the "trello" service and the "owner" account
    And I send a "POST" request to "/boards" with json body
    """
   {
    "name": "New Board from IntellIJ"
    }
    """
    And I validate the response has status code 200
    And I save the response as "B"
    And I save the request endpoint for deleting
    And I send a "GET" request to "/boards/{B.id}/lists"
    And I save the response as "L"

#Update a Checklist
  @acceptance @cleanData @checklists
  Scenario Outline: Trello PUT update a checklist name and pos on Card of TO DO List
    Given I send a "POST" request to "/cards?idList={L.[0].id}" with json body
    """
    {
    "name": "Card1 on To Do",
    "desc": "Description for Card1 on To Do"
    }
    """
    And I save the response as "C"
    And I send a "POST" request to "/checklists?idCard={C.id}" with json body
      """

      """
    And I send a "POST" request to "/checklists?idCard={C.id}" with json body
      """

      """
    And I save the response as "CL"
    And I validate the response has status code 200
    When I send a "PUT" request to "/checklists/{CL.id}" with json body
      """
      {
      <field>: <value>
      }
      """
    Then I validate the response has status code 200
    And Response body should match with "src/test/resources/schemas/trello/checklists/putChecklist.json" json schema
    Examples:
      |field    |value                |
      | "name"  | "checklists updated"|
      |  "pos"  |   20                |
      |  "pos"  | "top"               |

       #Update field on a Checklist
  @acceptance @cleanData @checklists
  Scenario Outline: Trello Update field on a Checklist on Card of TO DO List
    Given I send a "POST" request to "/cards?idList={L.[0].id}" with json body
    """
    {
    "name": "Card1 on To Do",
    "desc": "Description for Card1 on To Do"
    }
    """
    And I save the response as "C"
    And I send a "POST" request to "/checklists?idCard={C.id}" with json body
       """

      """
    And I save the response as "CL"
    And I validate the response has status code 200
    When I send a "PUT" request to "/checklists/{CL.id}/<field>" with json body
    """
    {
    "value": <value>
    }
    """
    Then I validate the response has status code 200
    Examples:
      |field|value                |
      | name| "checklists updated"|
      |  pos|   20                |

         #Update Checkitem on Card
#  @acceptance @cleanData @checklists
#  Scenario: Trello PUT Update Checkitem on a Checklist for Card of DONE List
#    Given I send a "POST" request to "/cards?idList={L.[2].id}" with json body
#    """
#    {
#    "name": "Card1 on Done",
#    "desc": "Description for Card1 on Done"
#    }
#    """
#    And I save the response as "C"
#    And I send a "POST" request to "/checklists?idCard={C.id}" with json body
#       """
#      "name": "Checklist"
#      """
#    And I save the response as "CL"
#    And I send a "POST" request to "/checklists/{CL.id}/checkItems" with json body
#   """
#    {
#    "name": "Checkitem on Checklist"
#    }
#    """
#    And I save the response as "CI"
#    When I send a "PUT" request to "/checklists/{CL.id}/checkItems/{CI.id}" with datatable
#     |pos|20|
#    Then I validate the response has status code 200