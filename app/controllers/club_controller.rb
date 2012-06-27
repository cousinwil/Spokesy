class ClubController < ApplicationController
  include StravaHelper

  def home
    strava_api = StravaApiHelper["www.strava.com"] 
    club_id = 5493
   
    # get the rides this year
    rides = strava_api.get("rides", :clubId=>club_id, :startDate=>Date.today - 365, :endDate=>Date.today + 1)
    ride_details = rides['rides'].map{|ride| strava_api.get("rides/#{ride['id']}")}
    @total_miles = 0
    @commute_miles = 0
    @longest_ride = 0
    @longest_rider = 0
    miles = 0

    ride_details.each do |ride|
      # convert meters to miles (all Strava data is in metric)
      miles = ride['ride']['distance'] * 0.000621 
      @total_miles += miles
      @commute_miles += miles if !!ride['ride']['commute']
      if miles > @longest_ride
        @longest_ride = miles
        @longest_rider = ride['ride']['athleteName']
      end
    end

    # get the rides this month
    rides_month = strava_api.get("rides", :clubId=>club_id, :startDate=>Date.today - 28, :endDate=>Date.today + 1)
    ride_details_month = rides['rides'].map{|ride| strava_api.get("rides/#{ride['id']}")}
    @total_miles_month = 0
    @commute_miles_month = 0
    @longest_ride_month = 0
    @longest_rider_month = 0
    miles_month = 0

    ride_details_month.each do |ride|
      # convert meters to miles (all Strava data is in metric)
      miles_month = ride['ride']['distance'] * 0.000621 
      @total_miles_month += miles_month
      @commute_miles_month += miles_month if !!ride['ride']['commute']
      if miles_month > @longest_ride_month
        @longest_ride_month = miles_month
        @longest_rider_month = ride['ride']['athleteName']
      end
    end

  end
end