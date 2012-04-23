Open-source Rails
================

Uses new Cloudfuji Auth. For local testing, set the cas_base_url in the devise initializer to http://cloudfuji.com/cas 

Local setup
------------

1.) clone the repo and cd into it
2.) rake db:migrate
3.) ./setup.sh

Admin panel is at /admin
username: admin@example.com
password: password

Those are default activeadmin credentials for you local pleasure :) The online credentials are better.

Tags are comma separated. Deleting a category will not delete the apps in the category. Did not add it just for safety.

TODO
-----

* move images from public/images to app/assets/images. And also fix image paths in CSS.
* validate attachment size, type, presence
