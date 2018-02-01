@test3
Feature: Test 3
  @shirt_search
  Scenario: Search for shirt
    Given: Mindy is a user
    And She is on the main page
    When She searches for a "Shirt"
    Then She see's at least one result
