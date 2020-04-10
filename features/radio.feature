Feature: Input Form

Background: Visit Google
  Given I am on the Google homepage

Scenario: Radio Male
  Given I visit the "radio page"
   When I click the "Male" button
    And I click the get value button
   Then I expect to see male as clicked

Scenario: Radio Female
  Given I visit the "radio page"
   When I click the "Female" button
    And I click the get value button
   Then I expect to see male as clicked

Scenario: Group radio buttons
  Given I visit the "radio page"
   When I click the male button
    And I click the 5 to 15 button
    And I click the get values button
   Then I expect the valid output
