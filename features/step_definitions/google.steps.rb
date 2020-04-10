Given('I am on the Google homepage') do
  visit('http://google.com')

  @google = Google.new

  expect(current_url).to include('google')

  expect(@google.homepage.visible?).to eq(true)
end

Given('I search for {string}') do |keyword|
  @google.search_for(keyword)
end

Then('I expect to see a list of results') do
  expect(@google.result_containers.count).to be > 0

  expect(@google.result_stats.text).to include('About', 'results', 'seconds')
end
