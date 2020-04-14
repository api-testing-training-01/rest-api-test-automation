#Feature: Sections

#  @cleanData
 # Scenario: Todoist POST sections with template
 #   Given I use the "todoist" service and the "owner" account
  #  And I send a "POST" request to "/projects" with datatable
   #   | name | new project |
   # And I save the response as "P"
    #And I save the request endpoint for deleting
    #Then I validate the response has status code 200
    #When I send a "POST" request to "/sections" with datable
 #     | project_id | {P.id}      |
 #     | name       | new section |
    #And I save the request endpoint for deleting
    #Then I validate the response has status code 200
