class ClubController < ApplicationController
  include StravaHelper

  def home
    strava_api = StravaApiHelper["www.strava.com"] 
    club_id = 5493
   
    # get the rides this year
    rides = strava_api.get("rides", :clubId=>club_id, :startDate=>Date.today - 365, :endDate=>Date.today + 1)
    idList = Ride.allIds
    usefulIds = []

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

    ride_details.each do |ride|
      puts 'NEW RIDER: ' + ride.to_s
      newRide = Ride.new(:commute => ride['ride']['commute'], 
        :distance => ride['ride']['distance'].to_f,
        :speed => ride['ride']['averageSpeed'].to_f,
        :vertical => ride['ride']['elevationGain'].to_f,
        :name => ride['ride']['athlete']['name'], 
        :date => ride['ride']['startDate'], 
        :ride_id => ride['ride']['id'])
      newRide.save
    end
  end
end