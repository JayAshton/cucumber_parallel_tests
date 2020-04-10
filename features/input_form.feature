Feature: Input Form

Background: Visit Google
  Given I am on the Google homepage

Scenario: Form Input 1
  Given I visit the "form page"
   When I enter a message
    And I click show message
   Then I expect to see the message

Scenario: Form Input 2
  Given I visit the "form page"
   When I enter the first value
    And I enter the second value
   When I click the get total button
   Then I expect to the correct value
