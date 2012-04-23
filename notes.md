NOTES
======

Localhost development setup
-----------------------------
 
This section helps you simulate Cloudfuji authentication on your localhost for your development purposes.

* Clone the rails app at <https://github.com/cloudfuji/kagi>

* Update the git module rubycas-server

        $ git submodule init
        $ git submodule update

* cd into the kagi/lib/rubycas-server directory. And install the dependencies by running bundle

        $ bundle

* Get back to the root directory of kagi.

        $ cd ../../

* To install dependencies and migrate the database, run the following

        $ bundle install
        $ rake db:migrate
 
  in the application's directory.

* Note the full path of the development database of that app above. The database is at db/development.sqlite3

* Copy the file cas/config.yml.sample as /etc/rubycas-server/config.yml

        cp kagi/cas/config.yml

* Edit the paths in the config file at /etc/rubycas-server/config.yml. All paths refer to the directories within the cloned kagi

* Start the rails development server for kagi by running

        $ rails s -p 3001

  in the cloned repo directory. This will run the CAS server in the port 3001 and therefore not disturbing any other rails dev servers you've started or will start later :)

* Then signup for a user account at <https://localhost:3001/users/sign_up> and thats how you sign up for more accounts when you need them :)

* Just leave this rails app running when you test your applications. And follow the next section to setup user authentication for your Cloudfuji Rails app.


Setting up devise with CAS auth (client) in third party Cloudfuji Rails applications
-----------------------------------------------------------

* Add the gem "devise_cas_authenticatable" to your Gemfile and do a

        $ bundle install

* Install devise
    
        $ rails g devise:install

* Generate your devise model
        $ rails g devise User
      
* Edit the migration in `db/migrate/XXXX_devise_create_users.rb` to use t.cas_authenticatable:
    class DeviseCreateUsers < ActiveRecord::Migration
      def self.up
        create_table(:users) do |t|
          t.cas_authenticatable
    
          t.string :username
    
        ...

        add_index :users, :username, :unique=>true

        ...

* Edit the model file `app/models/user.rb`, remove :database_authenticatable and :recoverable from the _devise_ method. Add :cas_authenticatable.

        devise :cas_authenticatable  # and other options


* Now find the devise initializer at _config/initializers/devise.rb_ and set the CAS base url. For localhost testing, with default options for rubycas-server, the config would look like
  
        if Rails.env.production?
            # TODO add cloudfuji CAS url later
        else
            config.cas_base_url = "https://localhost:3001/cas"
        end

* Use the normal Devise url helpers, you are good to go. For login, use the usual devise path `new_user_session_path` and for logout, use the path `destroy_user_session_path`. For example in erb views,

        <%= link_to "Login", new_user_session_path %>
        <%= link_to "Logout", destroy_user_session_path %>
