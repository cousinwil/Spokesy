class Ride < ActiveRecord::Base
  attr_accessible :athlete, :commute, :distance, :points, :speed, :vertical, :ride_id, :date, :name, :movingTime, :member_id
  belongs_to :member
  include ClubHelper

  def self.all_ids
    ids = []
    for ride in Ride.all
      ids.push(ride.ride_id)
    end
    return ids
  end   

  def self.save_new_rides(ride_details)
    ride_details.each do |ride|
        new_ride = Ride.new(:commute => ride['ride']['commute'], 
          :distance => ride['ride']['distance'].to_f,
          :speed => ride['ride']['averageSpeed'].to_f,
          :vertical => ride['ride']['elevationGain'].to_f,
          :name => ride['ride']['athlete']['name'], 
          :date => ride['ride']['startDate'], 
          :ride_id => ride['ride']['id'].to_i,
          :movingTime => ride['ride']['movingTime'].to_i,
          :member_id => (Member.find_by_strava_id(ride['ride']['athlete']['id'])).id)
        new_ride.save
    end
  end

  def self.find_rides
    strava_api = StravaApiHelper["www.strava.com"]
    @club_id = Club.first.club_id

    Club.get_members(@club_id, strava_api)

    id_list = Ride.all_ids
    for member in Member.all
      useful_ids = []
      rides = strava_api.get("rides", :athleteId=>member.strava_id, :startDate=>GlobalData.find(:first, :conditions => ['name = ?', 'start_date']).value.to_date, :endDate=>Date.today + 1)
      for ride in rides['rides']
        if ( !(id_list.include?(ride['id'].to_i)) )
          useful_ids.push(ride['id'].to_s)
        end
      end

      ride_details = useful_ids.map{|id| strava_api.get("rides/#{id}")} 

      Ride.save_new_rides(ride_details)
    end
  end
end
