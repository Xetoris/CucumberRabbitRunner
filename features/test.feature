@test
Feature: Test
  @main_page
  Scenario: Can load main page
    Given Frank is a user
    When He attempts to navigate to the main page
    Then He sees the landing page