When('I click the checkbox') do
  find('#isAgeSelected').click
end

Then('I expect the success message to be displayed') do
  expect(find('#txtAge').text).to eq("Success - Check box is checked")
end