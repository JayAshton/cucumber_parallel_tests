Capybara.configure do |config|
  config.run_server = false
  config.default_driver = if ENV['BROWSER'] == 'firefox'
                            :firefox
                          elsif ENV['BROWSER'] == 'firefox_headless'
                            :firefox_headless
                          elsif ENV['BROWSER'] == 'chrome'
                            :chrome
                          elsif ENV['BROWSER'] == 'chrome_headless'
                            :chrome_headless
                          elsif ENV['BROWSER'] == 'grid'
                            :grid
                          else
                            :firefox_headless
                          end
  config.default_max_wait_time = 10
  config.ignore_hidden_elements = false
end

require 'selenium-webdriver'

Capybara.register_driver :firefox_headless do |app|
  profile = Selenium::WebDriver::Firefox::Profile.new
  profile.assume_untrusted_certificate_issuer = true
  profile['browser.download.dir'] = "#{FileUtils.pwd}/data/downloads"
  profile['browser.download.folderList'] = 2
  profile['browser.helperApps.neverAsk.saveToDisk'] = 'text/html'
  options = ::Selenium::WebDriver::Firefox::Options.new
  options.args << '--headless'
  driver = Capybara::Selenium::Driver.new(app,
                                          browser: :firefox,
                                          options: options,
                                          profile: profile)

  # driver.browser.install_addon("#{FigNewton.path_to_addon}")

  driver
end

Capybara.register_driver :firefox do |app|
  profile = Selenium::WebDriver::Firefox::Profile.new
  profile.assume_untrusted_certificate_issuer = true
  profile['browser.download.dir'] = "#{FileUtils.pwd}/data/downloads"
  profile['browser.download.folderList'] = 2
  profile['browser.helperApps.neverAsk.saveToDisk'] = 'text/html'
  driver = Capybara::Selenium::Driver.new(app,
                                          browser: :firefox,
                                          profile: profile)

  # driver.browser.install_addon("#{FigNewton.path_to_addon}")

  driver
end

Capybara.register_driver :chrome do |app|
  profile = Selenium::WebDriver::Chrome::Profile.new
  profile['download.default_directory'] = "#{FileUtils.pwd}/data/downloads"
  args = ['--start-maximized']
  Capybara::Selenium::Driver.new(app,
                                 browser: :chrome,
                                 profile: profile,
                                 args: args)
end

Capybara.register_driver :chrome_headless do |app|
  Capybara::Selenium::Driver.new app, browser: :chrome,
                                      options: Selenium::WebDriver::Chrome::Options.new(args:
      ['start-maximized', '--window-size=1920,1080', '--headless'])
end

Capybara.register_driver :grid do |app|
  caps = Selenium::WebDriver::Remote::Capabilities.chrome(
    'goog:chromeOptions' => {
      'args' => ['--lang=en',
                 '--no-default-browser-check',
                 '--start-maximized',
                 '--window-size=1920,1080',
                 '--no-sandbox'],

      'prefs' => {
        'download.default_directory': '<path_to_dir>'
      }
    }
  )

  Capybara::Selenium::Driver.new(
    app,
    browser: :remote,
    url: '<url>',
    desired_capabilities: caps
  )
end
