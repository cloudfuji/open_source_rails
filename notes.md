NOTES
======

* Add the devise_cas_authenticatable gem to the Gemfile. Do not try a manual install via the command line, it throws an error.

    * It seems to have a cyclic dependency - https://gist.github.com/1013812
    * And that's because the gemspec of the gem is messed up - https://github.com/nbudin/devise_cas_authenticatable/blob/master/devise_cas_authenticatable.gemspec (the current version is tagged 1.0.0.aplha9 but that has the same messed up gemspec)
    * Filed an issue here https://github.com/nbudin/devise_cas_authenticatable/issues/13


Localhost development
-----------------------

The below steps are written with reference from http://code.google.com/p/rubycas-server/wiki/Downloads?tm=2

* Install the "rubycas-server". For now, we suggest using the Bushido fork of the gem if you are using Rails 3.1. The repo is at http://github.com/Bushido/rubycas-server. To use the gem from this repo, add this to your Gemfile.

    gem 'rubycas-server', :git => 'git://github.com/Bushido/rubycas-server.git'

* To run rubycas-server you need to specify a config file to it. Unfortunately, rubycas-server will force you to create a config file in /etc, in order to avoid it, you can setup the environment variable CONFIG_FILE so that it's available to the rubycas-server. An easier way is to just set the env var before running the command. It can be done by the following.

    $ CONFIG_FILE=/path/to/config.yml rubycas-server



...after everything

setting up devise with CAS auth
========================================

* Add the gem "devise_cas_authenticatable" to your Gemfile.

* Install devise

    rails g devise:install

* Generate your devise model, say User, and remove the options :database_authenticatable and :recoverable from the _devise_ method. Add :cas_authenticatable.

    devise :cas_authenticatable  # other options

* Now open up the migration for the devise model and remove _t.database_authenticatable_ and add _t.cas_authenticatable_. You'll have to remove the index for the email field. Also add the index for the usernames column if required (optional)

    add_index :users, :username, :unique=>true

* Now find the devise initializer at _config/initializers/devise.rb_ and set the CAS base url.

    config.cas_base_url = "your CAS base URL here"


