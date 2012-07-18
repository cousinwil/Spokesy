module ClubHelper
  include StravaHelper
  include SessionsHelper

#Data returned as follows
#data[0] = total miles
#data[1] = commute miles
#data[2] = longest ride
#data[3] = name of athlete with longest ride
	def getData(rides)
		data = [0, 0, 0, 0]
		rides.each do |ride|
			miles = ride.distance.to_f*0.000621 
      data[0] += miles
      if ride.commute
        data[1] += miles
      end
      if miles > data[2]
        data[2] = miles
        data[3] = ride.name
      end
    end
    return data
  end

  def findRides
    strava_api = StravaApiHelper["www.strava.com"]
    @club_id = 5493

    Member.get_members(@club_id, strava_api)

    idList = Ride.allIds
    for member in Member.all
      usefulIds = []
      rides = strava_api.get("rides", :athleteId=>member.strava_id, :startDate=>Date.today - 365, :endDate=>Date.today + 1)
      for ride in rides['rides']
        puts 'ID:' + ride['id'].to_s + 'NAME: ' + member.user_name
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