Feature: Checkbox

Background: Visit Google
  Given I am on the Google homepage

Scenario: Checkbox
  Given I visit the "checkbox page"
   When I click the checkbox
   Then I expect the success message to be displayed
