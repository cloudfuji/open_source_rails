opensourcerails
================

Local setup
------------

1.) clone the repo and cd into it
2.) rake db:migrate
3.) ./setup.sh

Admin panel is at /admin
username: admin@example.com
password: password

Those are default activeadmin credentials.

Tags are comma separated. Deleting a category will not delete the apps in the category. Did not add it just for safety.

TODO
-----

* 404

* JSON requests for the landing page's slider. The one on /projects

* margin below the slider's navigation on projects#show

* How do we select featured apps?
Have apps in a list (FeaturedApp model) called Featured apps and edit the list manualy every week by adding/deleting apps to it?

* Similar apps section on project#show page

* move images from public/images to app/assets/images. And also fix image paths in CSS.
* validate attachment size, type, presence,
* fix attachment upload field in projects#edit in the activeadmin panel
* change all image tags to use rails image helpers
