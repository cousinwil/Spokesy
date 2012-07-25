spoke-geek
==========

Cloning spoke-geek
git clone git@github.com:cousinwil/spoke-geek.git

Setting up your local database for spoke-geek
-> Run the following commands

rake db:migrate
rake db:seed
rails c
Ride.findRides
Tweet.pull
(ctrl + d to exit console)
Start up your local server (rails s)

If you notice at the top two events called Saturday Spandex are present, to add your own events do the following

Go to /sign_in
Sign in with the following credentials:
ride@spoke-geek.com
foobar

Go to /events/new
Create your own event, if the date of the event is before 8/4 and after yesterday's date the event will show up on the home page
