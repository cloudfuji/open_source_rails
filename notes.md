NOTES
======

* Filed an issue here https://github.com/nbudin/devise_cas_authenticatable/issues/13 and got the cyclic dependency issue fixed.


Localhost development
-----------------------

* Install the "rubycas-server". For now, we suggest using the Bushido fork of the gem if you are using Rails 3.1. The repo is at http://github.com/Bushido/rubycas-server. To use the gem from this repo, add this to your Gemfile.

    gem 'rubycas-server', :git => 'git://github.com/Bushido/rubycas-server.git'

* To run rubycas-server you need to specify a config file and create an SSL certificate. To make things easier, clone the repo at <https://github.com/Bushido/cas-credentials>, which should give you a sample config file and a demo SSL cert.

* Also clone the rails app at https://github.com/Bushido/cas-auth-app and do a 

    rake db:migrate

on it. Then signup for a user account at /users/sign_up

* Note the full path of the development database of that app above. THe database is at db/development.sqlite3

* Open up the config file in the cloned cas-credentials repo and change the path options. You'll have to specify the paths where the cas-server database (uses sqlite3) and the log file are to be created. Also change the path to the development database of the cas-auth app.

* Copy the config file to /etc/rubycas-server/config.yml

* start the rubycas-server

    # use sudo
    sudo rubycas-server
    
    # if you have rvm, use rvmsudo
    rvmsudo rubycas-server



Setting up devise with CAS auth (client)
========================================

* Add the gem "devise_cas_authenticatable" to your Gemfile.

* Install devise

    rails g devise:install

* Generate your devise model, say User, and remove the options :database_authenticatable and :recoverable from the _devise_ method. Add :cas_authenticatable.

    devise :cas_authenticatable  # other options

* Now open up the migration for the devise model and remove _t.database_authenticatable_ and add _t.cas_authenticatable_. You'll have to remove the index for the email field. Also add the index for the username column if required (optional)

    add_index :users, :username, :unique=>true

* Now find the devise initializer at _config/initializers/devise.rb_ and set the CAS base url. For localhost testing, with default optinos for rubycas-server, the config would look like

    config.cas_base_url = "https://localhost"

It will not conflict with anything you are running in port-80 (like apache, etc), because this runs no port 443 (ssl)

* Use the normal Devise url helpers, you are good to go :)

