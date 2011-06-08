NOTES
======

* Add the devise_cas_authenticatable gem to the Gemfile. Do not try a manual install via the command line, it throws an error.

    * It seems to have a cyclic dependency - https://gist.github.com/1013812
    * And that's because the gemspec of the gem is messed up - https://github.com/nbudin/devise_cas_authenticatable/blob/master/devise_cas_authenticatable.gemspec (the current version is tagged 1.0.0.aplha9 but that has the same messed up gemspec)
    * Filed an issue here https://github.com/nbudin/devise_cas_authenticatable/issues/13


Localhost development
-----------------------

The below steps are written with reference from http://code.google.com/p/rubycas-server/wiki/Downloads?tm=2

* Install the "rubycas-server" rubygem.

* When rubycas-server is run, it tries to create a config file in /etc/rubycas-server/config.yml and a log file in /var/log/casserver.log. For this it is recommended to run rubycas-server as root. But it also allows specifying the config file via 


 
