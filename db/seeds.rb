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