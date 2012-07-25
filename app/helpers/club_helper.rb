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
        data[3] = Ride.format_name(ride.name)
      end
    end
    return data
  end
end