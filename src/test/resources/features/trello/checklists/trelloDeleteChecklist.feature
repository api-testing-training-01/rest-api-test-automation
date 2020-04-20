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

#Create a Checklist
  @acceptance @cleanData @checklists
  Scenario: Trello POST create a checklist on Card of TO DO List
    Given I send a "POST" request to "/cards?idList={L.[0].id}" with json body
    """
    {
    "name": "Card1 on To Do",
    "desc": "Description for Card1 on To Do"
    }
    """
    And I save the response as "C"
    When I send a "POST" request to "/checklists?idCard={C.id}" with json body
       """

      """
    And I save the response as "CL"
    And I validate the response has status code 200
    When I send a "DELETE" request to "/checklists/{CL.id}"
    Then I validate the response has status code 200


#Delete Checkitem from Checklist
@acceptance @cleanData @checklists
Scenario: Trello Delete Checkitem from Checklist for Card of DONE List
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
  When I send a "POST" request to "/checklists/{CL.id}/checkItems" with json body
  """
    {
    "name": "Checkitem on Checklist"
    }
    """
  And I save the response as "CI"
  And I validate the response has status code 200
  When I send a "DELETE" request to "/checklists/{CL.id}/checkItems/{CI.id}"
  Then I validate the response has status code 200