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
	  description: "Join us Saturday, 7/28, at 10am at the Sports Basement for casual spin into Marin. We're going to go over the bridge, into Sausalito, and out past Tiburon on a no drop Paradise Loop ride.",
	  miles: 40,
	  name: "Saturday Spandex"
	},
    { date: "8/4/2012",
	  description: "Join us 8/4 for the 50th Marin Century and Mt. Tam Double! We have club members representing in the double and the metric centuries!!",
	  miles: 100,
	  name: "Marin Century"
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