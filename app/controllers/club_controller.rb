class ClubController < ApplicationController
  include StravaHelper

  def home
    strava_api = StravaApiHelper["www.strava.com"]
    @club_id = 5493

    Member.get_members(@club_id, strava_api)

    idList = Ride.allIds
    for member in Member.all
      usefulIds = []
      rides = strava_api.get("rides", :athleteId=>member.strava_id, :startDate=>Date.today - 365, :endDate=>Date.today + 1)
      for ride in rides['rides']
        puts 'ID:' + ride['id'].to_s
        if !(idList.include? ride['id'])
          puts 'TRUE'
          usefulIds.push(ride['id'].to_s)
        else
          puts 'FALSE'
        end
      end

      ride_details = usefulIds.map{|id| strava_api.get("rides/#{id}")} 

      Ride.saveNewRides(ride_details)
    end
  end
end