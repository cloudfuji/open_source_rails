NOTES
======

Localhost development setup
-----------------------------
 
This section helps you simulate Bushido authentication on your localhost for your development purposes.

* Clone the rails app at https://github.com/Bushido/cas-auth-app

* Update the git module rubycas-server

        $ git submodule update

* To install dependencies and migrate the database, run the following

        $ bundle install
        $ rake db:migrate
 
  in the application's directory.

* Note the full path of the development database of that app above. The database is at db/development.sqlite3

* Copy the file cas/config.yml.sample as /etc/rubycas-server/config.yml

* Edit the paths in the config file at /etc/rubycas-server/config.yml. All paths refer to the directories within the cloned cas-auth-app

* Start the rails development server for cas-auth-app by running

        $ rails s -p 3001

  in the cloned repo directory. This will run the CAS server in the port 3001 and therefore not disturbing any other rails dev servers you've started or will start later :)

* Then signup for a user account at <https://localhost:3001/users/sign_up> and thats how you sign up for more accounts when you need them :)

* Just leave this rails app running when you test your applications. And follow the next section to setup user authentication for your Bushido Rails app in the next section.


Setting up devise with CAS auth (client) in third party Bushido Rails applications
-----------------------------------------------------------

* Add the gem "devise_cas_authenticatable" to your Gemfile and do a

        $ bundle install

* Install devise
    
        $ rails g devise:install

* Generate your devise model, say User, and remove the options :database_authenticatable and :recoverable from the _devise_ method. Add :cas_authenticatable.

        devise :cas_authenticatable  # and other options

* Now open up the migration for the devise model and remove _t.database_authenticatable_ and add _t.cas_authenticatable_. You'll have to remove the index for the email field. Also add the index for the username column if required (optional)

        add_index :users, :username, :unique=>true

* Now find the devise initializer at _config/initializers/devise.rb_ and set the CAS base url. For localhost testing, with default options for rubycas-server, the config would look like
  
        if Rails.env.production?
            # TODO add bushido CAS url later
        else
            config.cas_base_url = "https://localhost:3001/cas"
        end

* Use the normal Devise url helpers, you are good to go :)
