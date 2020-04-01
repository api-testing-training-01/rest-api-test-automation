#Feature: Projects
#
#  Background:
#    Given I use the "pivotal" service and the "owner" account
#    And I send a "POST" request to "/projects" with datatable
#      | name             | Project created by cucumber |
#      | week_start_day   | Tuesday                     |
#      | new_account_name | New Account                 |
#      | iteration_length | 2                           |
#    And I save the response as "P"
#    And I save the request endpoint for deleting
#
#  @cleanData
#  Scenario Outline: Pivotal PUT Project with data table
#    When I send a "PUT" request to "/projects/{P.id}" with datatable
#      | name   | Project updated by cucumber |
#      | public | <public>                    |
#    Then I validate the response has status code 200
#    Examples:
#      | public |
#      | true   |
#      | false  |
