class Ride < ActiveRecord::Base
  attr_accessible :athlete, :commute, :distance, :points, :speed, :vertical, :ride_id, :date, :name, :movingTime
  include ClubHelper

  def self.allIds
  	ids = []
  	for ride in Ride.all
  		ids.push(ride.ride_id)
  	end
    return ids
  end   

  def self.saveNewRides(ride_details)
    ride_details.each do |ride|
      newRide = Ride.new(:commute => ride['ride']['commute'], 
        :distance => ride['ride']['distance'].to_f,
        :speed => ride['ride']['averageSpeed'].to_f,
        :vertical => ride['ride']['elevationGain'].to_f,
        :name => ride['ride']['athlete']['name'], 
        :date => ride['ride']['startDate'], 
        :ride_id => ride['ride']['id'],
        :movingTime => ride['ride']['movingTime'],
        :athlete => (Member.find_by_strava_id(ride['ride']['athlete']['id'])).id)
      newRide.save
    end
  end

  def self.findRides
    strava_api = StravaApiHelper["www.strava.com"]
    @club_id = Club.first.club_id

    Member.get_members(@club_id, strava_api)

    idList = Ride.allIds
    for member in Member.all
      usefulIds = []
      rides = strava_api.get("rides", :athleteId=>member.strava_id, :startDate=>Date.today - 365, :endDate=>Date.today + 1)
      for ride in rides['rides']
        if !(idList.include? ride['id'])
          usefulIds.push(ride['id'].to_s)
        end
      end

      ride_details = usefulIds.map{|id| strava_api.get("rides/#{id}")} 

      Ride.saveNewRides(ride_details)
    end
  end
end
