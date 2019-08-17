@search
Feature: Search
  @shirt_search
  Scenario: Search for shirt
    Given Mindy is a user
    And She is on the main page
    When She searches for "Shirts"
    Then She sees at least one result
