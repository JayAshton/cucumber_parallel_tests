class Google < SitePrism::Page
  include RSpec::Matchers

  element  :homepage, '#lga'
  elements :search_input, '.gLFyf.gsfi'
  elements :google_search_button, '.gNO89b'
  elements :result_containers, '.rc'
  element  :result_stats, '#result-stats'

  def search_for(input)
    search_input.first.set(input)

    google_search_button.first.click

    expect(current_url).to include('search')
  end
end
