
source 'http://rubygems.org'

# Core rails gems
gem 'rails', '3.1.3'

# Database gems
gem 'pg'

# All-around goodness
gem 'airbrake'

gem 'bushido'

# Authentication
gem 'devise'
gem 'devise_bushido_authenticatable'

# Network related
gem 'nestful'
gem 'heroku'
gem 'thin'
gem 'aws-sdk'
gem 'aws-s3'

# Model behavior
gem 'acts-as-taggable-on'
gem 'paperclip'

# Asset control
# Note that sass-rails must come before active_admin
gem 'sprockets'
gem 'coffee-script'
gem 'uglifier'
gem 'jquery-rails'
gem 'sass-rails', "~> 3.1"

# Frontend-helpers
# Note that meta_search prerelease is required for activeadmin
gem "meta_search", '>= 1.1.0.pre'
gem 'client_side_validations', '3.0.12'
gem 'activeadmin', '0.3.4'  #:git=>"https://github.com/gregbell/active_admin/" #, :branch=>"rails-3-1"
gem 'nested_form', :git=>"https://github.com/ryanb/nested_form.git"

group :assets do
  gem 'uglifier'
end

group :test, :development do
  gem 'turn', :require => false
  gem 'spork'
  gem 'rspec-rails', '>= 2.7.0'
  gem 'remarkable_activerecord', ">=4.0.0.alpha"
  gem 'fabrication'
  gem 'forgery'
  gem 'awesome_print'
  gem 'tane'
end

group :test do
  gem 'cucumber-rails'
end
