@products
Feature: Products
  @dress_listings
  Scenario: Can view dresses
    Given Lucie is a user
    And She is on the main page
    When She views dress products
    Then She sees several listings for dresses
  @dress_details
  Scenario: Can view dress details
    Given Sam is a user
    And He is on the main page
    When He views dress products
    And He attempts to view the details for the first dress
    Then He sees the dress details