Feature: Google

Background: Visit Google
  Given I am on the Google homepage

Scenario: Search for a keyword
  Given I search for "Shoes"
   Then I expect to see a list of results
