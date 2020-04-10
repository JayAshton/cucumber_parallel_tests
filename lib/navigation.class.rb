class Navigation < SitePrism::Page
  include RSpec::Matchers

  def visit_page(input)
    pages = {
                "form page" => "basic-first-form-demo",
                "checkbox page" => "basic-checkbox-demo",
                "radio page" => "basic-radiobutton-demo",
                "select page" => "basic-select-dropdown-demo",
                "alerts page" => "javascript-alert-box-demo",
                "modal page" => "bootstrap-modal-demo"
             }

    selected_page = pages[input]

    return full_url = "https://www.seleniumeasy.com/test/#{selected_page}.html"
  end
end
