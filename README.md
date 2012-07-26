#Spokesy

##What is it?
Spokesy is a simple RoR app for making a one page Bicycle Club/Velo Club website. It uses the Twitter API and Strava API to pull in tweets and rides. The site displays these along your club info, events, and more.

##Set Up & Deployment [TO BE EDITED] 

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
