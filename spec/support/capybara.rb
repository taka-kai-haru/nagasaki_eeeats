# # Setup chrome headless driver
# Capybara.server = :puma, { Silent: true }
#
# Capybara.javascript_driver = :selenium_chrome_headless
#
# Capybara.default_max_wait_time = 30
#
# Capybara.save_path = "#{Dir.pwd}/screenshots"
#
# Capybara.app_host='http://192.168.11.8:3000'
#
# Capybara.register_driver :chrome_headless do |app|
#   options = ::Selenium::WebDriver::Chrome::Options.new
#
#   options.add_argument('--headless')
#   options.add_argument('--no-sandbox')
#   options.add_argument('--disable-dev-shm-usage')
#   options.add_argument('--window-size=1400,1400')
#
#   Capybara::Selenium::Driver.new(app, browser: :chrome, options: options)
#
#
# end
#
#
#
# # Setup rspec
# RSpec.configure do |config|
#   config.before(:each, type: :system) do
#     # driven_by :selenium_chrome_headless, screen_size: [1400, 1400]
#     # driven_by :selenium, using: :headless_chrome, options: {
#     #   browser: :remote,
#     #   desired_capabilities: :chrome
#     # }
#     # Capybara.server_host = 'web'
#     # Capybara.always_include_port = true
#
#     driven_by :rack_test
#     #
#     # driven_by :selenium
#     #
#   end
#
#   config.before(:each, type: :system, js: true) do
#     driven_by :selenium_chrome_headless
#     # driven_by :rack_test
#     # driven_by :selenium
#   end
#
# end

RSpec.configure do |config|
  config.before(:each, type: :system) do
    driven_by :rack_test
  end

  config.before(:each, type: :system, js: true) do
    driven_by :selenium, using: :headless_chrome, screen_size: [1400, 1400]
  end
end



# Capybara.javascript_driver = ENV['DRIVER'] ? ENV['DRIVER'].to_sym : :chrome
#
# Capybara.app_host = [:safari, :chrome, :firefox, :iphone, :ipad].include?(Capybara.javascript_driver) ? "http://localhost:3000" : "http://192.168.11.8:3000"
# # Capybara.default_wait_time = 10
# Capybara.default_max_wait_time = 10
# Capybara.run_server = false
#
# Capybara.register_driver :chrome do |app|
#   Capybara::Selenium::Driver.new app,
#                                  browser: :remote,
#                                  desired_capabilities: Selenium::WebDriver::Remote::Capabilities.chrome,
#                                  url: "http://192.168.11.8:4444/wd/hub"
# end



