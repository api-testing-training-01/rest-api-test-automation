@allPivotalProject
Feature: Projects

  @cleanData @acceptance
  Scenario: Pivotal POST Create basic Project
    Given I use the "pivotal" service and the "owner" account
    When I send a "POST" request to "/projects" with json body
    """
    {
    "name": "Basic project created by cucumber"
    }
    """
    And I save the request endpoint for deleting
    Then I validate the response has status code 200
      And Response body should match with "src/test/resources/schemas/examples/postSchema.json" json schema
      And I validate the response contains:
        | kind             | project                     |
        | name             | Basic project created by cucumber |
        | public           | false                        |
        | project_type     | private                      |

  @cleanData @acceptance
  Scenario: Pivotal POST Create project with all
    Given I use the "pivotal" service and the "owner" account
    When I send a "POST" request to "/projects" with json body
    """
    {"name":"Full project created by cucumber",
      "atom_enabled":true,
      "automatic_planning": false,
      "bugs_and_chores_are_estimatable": true,
      "enable_following": false,
      "enable_incoming_emails": false,
      "enable_tasks": false,
      "has_google_domain": true,
      "initial_velocity": 10,
      "iteration_length": 1,
      "kind": "project",
      "point_scale": "0,1,2,3",
      "point_scale_is_custom": true,
      "project_type": "private",
      "public": true
     }
    """
    And I save the request endpoint for deleting
    Then I validate the response has status code 200
    And Response body should match with "src/test/resources/schemas/examples/postSchema.json" json schema
    And I validate the response contains:
      | kind             | project                     |
      | name             | Full project created by cucumber |
      | version          | 1                                |
      | iteration_length | 1                                |
      | week_start_day   | Monday                           |
      | point_scale      | 0,1,2,3                        |
      | point_scale_is_custom  |  false                     |
      | bugs_and_chores_are_estimatable  | true            |
      | automatic_planning               | false             |
      | enable_tasks           | false                   |
      | initial_velocity       | 10                     |
      | atom_enabled           | true                  |
      | enable_following       | true                   |
      | enable_incoming_emails | false                   |
      | has_google_domain      | false                  |
      | public           | true                        |
      | project_type     | public                      |

  @cleanData @regression @negative
  Scenario: Pivotal POST Create Project without title
    Given I use the "pivotal" service and the "owner" account
    When I send a "POST" request to "/projects" with json body
    """
    {
    "name": ""
    }
    """
    Then I validate the response has status code 400
    And I validate the response contains:
      | code              | invalid_parameter                                        |
      | kind              | error                                                    |
      | error             | One or more request parameters was missing or invalid.   |
      | general_problem   | this endpoint requires the parameter: name               |


  @cleanData @regression @negative
  Scenario: Pivotal POST Create Project with duplicate name
    Given I use the "pivotal" service and the "owner" account
    When I send a "POST" request to "/projects" with json body
    """
    {
    "name": "Project duplicate"
    }
    """
    Then I validate the response has status code 200
    And I save the response as "PostResponse"
    And I send a "POST" request to "/projects" with json body
    """
    {
    "name": "Project duplicate"
    }
    """
    Then I validate the response has status code 400
    And I validate the response contains:
      | code             | invalid_parameter                                            |
      | kind             | error                                                        |
      | error            | One or more request parameters was missing or invalid.       |
      | general_problem  | The project name you entered is already taken.               |
    Then I send a "DELETE" request to "/projects/{PostResponse.id}"

  @cleanData @acceptance
  Scenario: Pivotal POST Create Project with limit name
    Given I use the "pivotal" service and the "owner" account
    When I send a "POST" request to "/projects" with json body
    """
    {
    "name": "Project name contain only with 50 characters  test"
    }
    """
    And I save the request endpoint for deleting
    Then I validate the response has status code 200
    And Response body should match with "src/test/resources/schemas/examples/postSchema.json" json schema
    And I validate the response contains:
      | kind             | project                     |
      | name             | Project name contain only with 50 characters  test |
      | public           | false                        |
      | project_type     | private                      |

  @cleanData @negative
  Scenario: Pivotal POST Create Project with name more than 50 characters
    Given I use the "pivotal" service and the "owner" account
    When I send a "POST" request to "/projects" with json body
    """
    {
    "name": "Project name contain more than 50 characters in name field"
    }
    """
    And I save the request endpoint for deleting
    Then I validate the response has status code 400
    And I validate the response contains:
      | code             | invalid_parameter                                            |
      | kind             | error                                                        |
      | error            | One or more request parameters was missing or invalid.       |
      | general_problem  | This extended_string is too long:  'Project name contain more than 50 characters in name field'                                                              |
      | requirement      | 'name' parameter must be 50 characters or less.               |

  @cleanData @negative
  Scenario: Pivotal POST Create Project with invalid request
    Given I use the "pivotal" service and the "owner" account
    When I send a "POST" request to "/projects" with json body
    """
    name: Invalid request
    """
    Then I validate the response has status code 500
    And I validate the response contains:
      | code             | unhandled_condition                     |
      | kind             | error                                   |
      | error            | An unexpected condition occurred.       |

  @cleanData @acceptance
  Scenario: Pivotal POST Create Project with special characters
    Given I use the "pivotal" service and the "owner" account
    When I send a "POST" request to "/projects" with json body
    """
    {
    "name": "NAME:°!#$%&/()=?¡*¨[]_:;><^`~¬*@{}-.,+´¿'"
    }
    """
    And I save the request endpoint for deleting
    Then I validate the response has status code 200
    And Response body should match with "src/test/resources/schemas/examples/postSchema.json" json schema
    And I validate the response contains:
      | kind             | project                     |
      | name             | NAME:°!#$%&/()=?¡*¨[]_:;><^`~¬*@{}-.,+´¿' |
      | public           | false                        |
      | project_type     | private                      |

  @cleanData @negative
  Scenario: Pivotal POST Create Project with invalid URL
    Given I use the "pivotal" service and the "owner" account
    When I send a "POST" request to "/projectsInvalid" with json body
    """
    {
    "name": "Invalid URL"
    }
    """
    Then I validate the response has status code 404
    And I validate the response contains:
      | code             | route_not_found                     |
      | kind             | error                                   |
      | error            | The path you requested has no valid endpoint.       |

  @cleanData @acceptance
  Scenario: Pivotal POST Create Project from HTTP method
    Given I use the "pivotal" service and the "owner" account
    When I send a "POST" request to "http://www.pivotaltracker.com/services/v5/projects" with json body
    """
    {
    "name": "Project created from HTTP"
    }
    """
    Then I validate the response has status code 301

  @cleanData @acceptance
    Scenario: Pivotal POST Create project for membership
    Given I use the "pivotal" service and the "owner" account
    When I send a "POST" request to "/projects" with json body
    """
    {
    "name": "Project created by cucumber by membership"
    }
    """
    Then I validate the response has status code 200
    And I save the response as "PostResponse"
    Then I send a "POST" request to "/projects/{PostResponse.id}/memberships" with json body
    """
    {
    "email":"testing@testing.testmail","role":"member"
    }
    """
     And I validate the response has status code 200
     And I validate the response contains:
      | kind                        | project_membership                     |
      | role                        | member                                 |
    Then I send a "DELETE" request to "/projects/{PostResponse.id}"
    Then I validate the response has status code 204