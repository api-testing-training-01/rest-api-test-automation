#Feature: Boards
#
#  Background:
#    Given I use the "trello" service and the "owner" account
#      And I send a "POST" request to "/boards" with json body
#        """
#        {
#        "name": "Board0001 created by cucumber"
#        }
#        """
#      And I save the response as "P"
#  @cleanData
#  Scenario: Trello PUT Board
#    When I send a "PUT" request to "/boards/{P.id}" with json body
#      """
#      {
#      "name": "Board0001 updated by cucumber"
#      }
#      """
#    Then I validate the response has status code 200
#      And I send a "DELETE" request to "/boards/{P.id}"
#      And I validate the response has status code 200
