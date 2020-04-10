When('I click the {string} button') do |value|
  @value = value

  value_xpath = '//input[@value="' + @value + '"]'

  all(:xpath, value_xpath).first.click
end

And('I click the get value button') do
  find('#buttoncheck').click
end

Then('I expect to see male as clicked') do
  expect(find('.radiobutton').text).to eq("Radio button '#{@value}' is checked")
end

When('I click the male button') do
  all(:xpath, '//input[@value="Male"]').last.click
end

And('I click the 5 to 15 button') do
  all(:xpath, '//input[@value="5 - 15"]').first.click
end

And('I click the get values button') do
  click_button("Get values")
end

Then('I expect the valid output') do
  expect(find('.groupradiobutton').text).to include("Sex : Male")
  expect(find('.groupradiobutton').text).to include(" Age group: 5 - 15")
end