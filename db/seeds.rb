# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
User.create([
	{ name: "Spokester",
	  email: "ride@spoke-geek.com",
	  password: "foobar",
	  password_confirmation: "foobar",
	  admin: 'true'
	}])
Event.create([
	{ date: "7/28/2012",
	  description: "Join us at 10am at the Sports Basement for casual spin into Marin. We're going to go over the bridge, into Sausalito, and out past Tiburon on a no drop Paradise Loop ride.",
	  miles: 40,
	  name: "Saturday Spandex"
	}])

Member.create([
	{
      user_name: 'Kevin Anderson',
      strava_id: 14210,
		}])
GlobalData.create([
	{
    name: 'club_id',
    value: '5493'
	},
  {
    name: 'twitter',
    value: 'SpokeGeek'
  }])