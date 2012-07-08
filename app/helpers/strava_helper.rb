module StravaHelper

  require 'net/http'
  require 'json'
  require 'date'

  class StravaApiHelper < Struct.new(:base_url)

    def get(service, params = {})
      url = "http://#{self.base_url or "www.strava.com"}/api/v1/#{service}"
      # escape strings and format dates and times
      params.each_pair do |k, v|
        params[k] = URI.escape(v) if v.is_a? String
        params[k] = v.strftime("%Y-%m-%d") if v.is_a? Date
        params[k] = v.strftime("%Y-%m-%dT%H:%M:%S") if v.is_a? Time
      end

      url << "?#{params.map{|k, v| "#{k}=#{v}"}.join("&")}" if !params.empty?
      JSON.parse(Net::HTTP.get(URI.parse(url)))
    end

  end

  def get_data(club_id, time_offest)
    strava_api = StravaApiHelper["www.strava.com"] 
    #Spoke Geek club_id = 5493
   
    # get the rides this year
    # see http://app.strava.com/api/v1/rides/77563 for sample json
    club = strava_api.get("members", :clubId=>club_id)

    member_details = club['members'].map{|member| strava_api.get("clubs/club_id/members}")}
    #@total_miles = 0
    #@commute_miles = 0
    #@longest_ride = 0
    #@longest_rider = 0
    #miles = 0
    athlete_name = 0
    athlete_id = 0

    member_details.each do |member|
      athlete_name = member['club']['member']['name']
      athlete_id = member['club']['member']['id']

      member = Member.find(:first, :conditions => ["strava_id='#{athlete_id}'"])
      unless member
        Member.create([{ user_name: athlete_name.to_s, strava_id: athlete_id.to_i}])
      end

    end


  end
end 