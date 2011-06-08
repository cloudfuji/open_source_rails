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

* To run rubycas-server you need to specify a config file to it.


 
