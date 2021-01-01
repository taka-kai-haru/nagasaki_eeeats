source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }



# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails',      '6.0.3'

# Use Puma as the app server
gem 'puma',       '4.3.4'
# Use SCSS for stylesheets
gem 'sass-rails', '6.0.0'
# Transpile app-like JavaScript. Read more: https://github.com/rails/webpacker
gem 'webpacker',  '4.0.7'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '5.2.0'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder',   '2.9.1'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'
# Use Active Model has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Active Storage variant
# gem 'image_processing', '~> 1.2'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap',   '1.4.5', require: false

# sing up function
gem 'devise'

# active storage validation
gem 'active_storage_validations', '0.8.2'
# image size control
gem 'image_processing',           '1.9.3'
gem 'kaminari'
gem 'mini_magick', '4.9.5'

gem 'aws-sdk-s3', '1.46.0', require: false

gem 'geokit-rails',               '2.3.1'

gem 'pg', '1.2.3'

gem 'tzinfo', '~> 1.2', '>= 1.2.8'
gem 'tzinfo-data', '~> 1.2020', '>= 1.2020.4'
gem 'zeitwerk', '~> 2.4', '>= 2.4.2'
gem 'rake', '~> 13.0', '>= 13.0.3'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  # gem 'byebug',  '11.0.1', platforms: [:mri, :mingw, :x64_mingw]
  # Use sqlite3 as the database for Active Record
  # gem 'sqlite3', '1.4.1'
  # gem 'pry'
  # gem 'pry-byebug'
  gem 'rspec-rails'
  gem 'factory_bot_rails'
  gem 'debase', '~> 0.2.4.1'
  gem 'debase-ruby_core_source',  '0.10.11'
  gem 'ruby-debug-ide'
  # gem 'aws-partitions',           '1.386.0'
end

group :development do
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'listen',                '3.1.5'
  gem 'web-console',           '4.0.1'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring',                '2.1.0'
  gem 'spring-watcher-listen', '2.0.1'
  gem 'spring-commands-rspec'
  gem 'solargraph'
end


group :test do
  # Adds support for Capybara system testing and selenium driver
  gem 'capybara',                 '3.32.2'
  # Easy installation and use of web drivers to run system tests with browsers
  gem 'selenium-webdriver',       '3.142.7'
  gem 'webdrivers'
  # tests gem
  gem 'guard',                    '2.16.2'
  # gem 'guard-minitest',           '2.4.6'
  # gem 'minitest',                 '5.14.1'
  # gem 'minitest-reporters',       '1.3.8'
  gem 'rails-controller-testing', '1.0.4'

end

group :production do
  # Use pg as the database for Active Record(production)
  # gem 'pg', '1.1.4'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
# gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
