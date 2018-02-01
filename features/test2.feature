@test_2
Feature: Test 2
  @dress_listings
  Scenario: Can view dresses
    Given Lucie is a user
    When She attempts to view dresses listings
    Then She sees several listings for dresses
  @dress_details
  Scenario: Can view dress details
    Given Sam is a user
    And She is on the dresses listings
    When She attempts to view the details for the first dress
    Then She sees the dress details