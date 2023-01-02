Feature: Mock one node in a flow
  Example for testing a flow with a service mocked out

  Scenario: The flow has a node that depends on a service
    Given a blank body and no service for USD to GBP
    When I ask if the results are correct 
    Then the results should validate successfully
