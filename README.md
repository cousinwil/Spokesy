#Spoke Geek

##What is it?
Spoke Geek is a RoR app for the Spoke Geek Bicycle club. It pulls in tweets and rides from the outside world and displays them along with club info, events, and more.

##Environment Set Up

1. Clone spoke-geek
  * $ git clone git@github.com:cousinwil/spoke-geek.git
2. $ bundle install (We're using Rails 3.2.3 and Ruby 1.9.2)
3. Setting up your local database for spoke-geek
  * $ rake db:migrate
  * $ rake db:seed
  * $ rails c
      - Ride.findRides
      - Tweet.pull
3. Add your own events
  * Visit http://localhost:3000/sign_in
  * Sign in with the following credentials: ride@spoke-geek.com / foobar
  * Go to http://localhost:3000/events/new
  * Create your own event, if the date of the event is before 8/4 and after yesterday's date the event will show up on the home page
