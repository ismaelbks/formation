source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.1.3'
# Use sqlite3 as the database for Active Record
gem 'sqlite3'
# Use Puma as the app server
gem 'puma', '~> 3.7'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.2'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 3.0'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

#jquery gem
gem 'jquery-rails'


# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

#Customized with bootswatch theme : Lumen.
gem 'bootstrap-sass', '~> 3.3.6'

#Authentification system
gem 'devise'

#Active Admin (Console d'administration)
gem "activeadmin"
#Thme artic admin for active admin: https://github.com/cle61/arctic_admin
gem 'arctic_admin'

#adding .xls export to active admin
#gem 'activeadmin-axlsx' #The gem seems to not work for now on

#Managing image uploads with Shrine
gem 'fastimage'
gem 'image_processing'
gem 'mini_magick'
gem "shrine"

#Js cropping of the image uploaded
gem 'rails-assets-jcrop', source: 'https://rails-assets.org'

#Project states managing
gem 'statesman'


group :test do
  gem 'rspec'
  gem "rspec-rails"
  gem "factory_girl"
  gem "factory_girl_rails"
  gem "faker"
  gem "database_cleaner"
end


group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  # Adds support for Capybara system testing and selenium driver
  gem 'capybara', '~> 2.13'
  gem 'selenium-webdriver'
  gem 'shog'
  gem 'simplecov'
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'listen', '>= 3.0.5', '< 3.2'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem "rubycritic", :require => false
  gem 'web-console', '~> 2.0'   # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'better_errors'
  gem 'figaro'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
