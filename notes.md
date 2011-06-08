NOTES
======

* Add the devise_cas_authenticatable gem to the Gemfile. Do not try a manual install via the command line, it throws an error.

    * It seems to have a cyclic dependency - https://gist.github.com/1013812
    * And that's because the gemspec of the gem is messed up - https://github.com/nbudin/devise_cas_authenticatable/blob/master/devise_cas_authenticatable.gemspec (the current version is tagged 1.0.0.aplha9 but that has the same messed up gemspec)
    * Filed an issue here https://github.com/nbudin/devise_cas_authenticatable/issues/13


 
