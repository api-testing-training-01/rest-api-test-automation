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

#Get a Checklist
  @acceptance @cleanData @checklists
  Scenario: Trello GET a checklist on Card of TO DO List
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
    When I send a "GET" request to "/checklists/{CL.id}"
    Then I validate the response has status code 200
    And Response body should match with "src/test/resources/schemas/trello/checklists/getChecklist.json" json schema

    #Get field on a Checklist
  @acceptance @cleanData @checklists
  Scenario Outline: Trello Get field on a Checklist on Card of TO DO List
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
    When I send a "GET" request to "/checklists/{CL.id}/<field>"
    Then I validate the response has status code 200
    Examples:
      |field|
      | name|
      |  pos|

    #Get the Board the Checklist is on
  @acceptance @cleanData @checklists
  Scenario: Trello GET the Board the Checklist is on for Card of TO DO List
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
    When I send a "GET" request to "/checklists/{CL.id}/board"
    Then I validate the response has status code 200

       #Get the Card a Checklist is on
  @acceptance @cleanData @checklists
  Scenario: Trello GET the Card a Checklist is on for Card of TO DO List
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
    When I send a "GET" request to "/checklists/{CL.id}/cards"
    Then I validate the response has status code 200

    #Get Checkitems on a Checklist
  @acceptance @cleanData @checklists
  Scenario: Trello GET Checkitems on a Checklist for Card of DONE List
    Given I send a "POST" request to "/cards?idList={L.[2].id}" with json body
    """
    {
    "name": "Card1 on Done",
    "desc": "Description for Card1 on Done"
    }
    """
    And I save the response as "C"
    And I send a "POST" request to "/checklists?idCard={C.id}" with json body
      """

      """
    And I save the response as "CL"
    And I send a "POST" request to "/checklists/{CL.id}/checkItems" with json body
   """
    {
    "name": "Checkitem on Checklist"
    }
    """
    When I send a "GET" request to "/checklists/{CL.id}/checkItems"
    Then I validate the response has status code 200

       #Get a Checkitem on a Checklist
  @acceptance @cleanData @checklists
  Scenario: Trello GET a Checkitem on a Checklist for Card of DONE List
    Given I send a "POST" request to "/cards?idList={L.[2].id}" with json body
    """
    {
    "name": "Card1 on Done",
    "desc": "Description for Card1 on Done"
    }
    """
    And I save the response as "C"
    And I send a "POST" request to "/checklists?idCard={C.id}" with json body
       """

      """
    And I save the response as "CL"
    And I send a "POST" request to "/checklists/{CL.id}/checkItems" with json body
   """
    {
    "name": "Checkitem on Checklist"
    }
    """
    And I save the response as "CI"
    When I send a "GET" request to "/checklists/{CL.id}/checkItems/{CI.id}"
    Then I validate the response has status code 200