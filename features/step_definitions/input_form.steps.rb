When('I enter a message') do
  @message = "This is a test message"
  all('#user-message').first.set(@message)
end

And('I click show message') do
  click_button("Show Message")
end

Then('I expect to see the message') do
  expect(find('#display').text).to eq(@message)
end

When('I enter the first value') do
  @val = "1"

  find('#sum1').set(@val)
end

And('I enter the second value') do
  find('#sum2').set(@val)
end

When('I click the get total button') do
  click_button("Get Total")
end

Then('I expect to the correct value') do
  final_value = "#{@val.to_i + @val.to_i}"

  expect(find('#displayvalue').text).to eq(final_value)
end