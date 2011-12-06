source 'http://rubygems.org'

# Core rails gems
gem 'rails', '3.1.0'

# Database gems
gem 'pg'

# All-around goodness
gem 'bushido', :git=>"https://github.com/Bushido/bushidogem.git"

# Authentication
gem 'devise'
gem 'devise_bushido_authenticatable', :git=>"https://github.com/Bushido/devise_cas_authenticatable.git"

# Network related
gem 'nestful'
gem 'heroku'
gem 'thin'
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
gem 'sass-rails', "~> 3.1.0.rc"

# Frontend-helpers
# Note that meta_search prerelease is required for activeadmin
gem "meta_search", '>= 1.1.0.pre'
gem 'client_side_validations', '3.0.12'
gem 'activeadmin', :git=>"https://github.com/gregbell/active_admin/" #, :branch=>"rails-3-1"
gem 'nested_form', :git=>"https://github.com/ryanb/nested_form.git"

group :assets do
  gem 'uglifier'
end

group :test, :development do
  gem 'turn', :require => false
  gem 'spork'
  gem 'rspec-rails'
  gem 'remarkable_activerecord', ">=4.0.0.alpha"
  gem 'cucumber-rails'
  gem 'fabrication'
  gem 'forgery'
  gem 'awesome_print'
  gem 'tane', :git=>"https://github.com/Bushido/tane.git"
end
