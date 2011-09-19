source 'http://rubygems.org'

gem 'rails', '3.1.0'

# Bundle edge Rails instead:
# gem 'rails',     :git => 'git://github.com/rails/rails.git'

gem 'sqlite3'
gem 'devise'
gem 'devise_bushido_authenticatable', :git=>"https://github.com/Bushido/devise_cas_authenticatable.git"

gem 'acts-as-taggable-on'
gem 'paperclip'
gem 'client_side_validations', '3.0.12'
gem 'nestful'

# sass-rails must be before active_admin

gem 'sass-rails', "~> 3.1.0.rc"

# NOTES meta_search prerelease is required for activeadmin
gem "meta_search",    '>= 1.1.0.pre'
gem 'activeadmin', :git=>"https://github.com/gregbell/active_admin/" #, :branch=>"rails-3-1"

gem 'nested_form', :git=>"https://github.com/ryanb/nested_form.git"

gem 'sprockets'
gem 'coffee-script'
gem 'uglifier'
gem 'jquery-rails'

group :assets do
#  gem 'therubyracer'
#  gem 'sass-rails', "~> 3.1.0.rc"
#  gem 'coffee-rails', "~> 3.1.0.rc"
  gem 'uglifier'
end


# To use debugger
# gem 'ruby-debug19', :require => 'ruby-debug'

group :test, :development do
  gem 'turn', :require => false
  gem 'spork'
  gem 'rspec-rails'
  gem 'remarkable_activerecord', ">=4.0.0.alpha"
  gem 'cucumber-rails'
  gem 'fabrication'
  gem 'forgery'
end
