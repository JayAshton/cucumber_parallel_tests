Given('I am on the Google homepage') do
    visit('http://google.com')
end

Given('I visit the {string}') do |page|
@page = page

@navigation = Navigation.new

visit(@navigation.visit_page(@page))
end