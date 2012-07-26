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
        data[3] = GlobalData.format_name(ride.name)
      end
    end
    return data
  end

  #Returns the three highest vertical values and the respective names
  #Display as follows
  #1st highest[3] - highest[0]
  #2nd highest[4] - highest[1]
  #3rd highest[5] - highest[2]
  def findHighest(var, date)
    highest = [0, 0, 0, '', '', '']
    for member in @members
      amount = var.call(member, date)
      name = GlobalData.format_name(member.user_name)
      if amount >= highest[0]
        highest[2] = highest[1]
        highest[5] = highest[4]
        highest[1] = highest[0]
        highest[4] = highest[3]
        highest[3] = name
        highest[0] = amount
      elsif amount >= highest[1]
        highest[2] = highest[1]
        highest[5] = highest[4]
        highest[1] = amount
        highest[4] = name
      elsif amount > highest[2]
        highest[2] = amount
        highest[5] = name
      end
    end
    return highest
  end

      #Finds the total vertical of the given athlete id
  def findVert(member, date)
    rides = Ride.where('athlete = ? AND date > ?', member.id, date)
    vert = 0
    for ride in rides
      vert += ride.vertical*3.2808399
    end
    return vert
  end

  def getPoints(member, date)
    rides = Ride.where('athlete = ? AND date > ?', member.id, date)
    points = 0
    for ride in rides
      points += (ride.vertical*3.2808399)/100
      points += ride.distance.to_f*0.000621
    end
    return points.to_i
  end

  def getAveSpeed(member, date)
    rides = Ride.where('athlete = ? AND date > ?' , member.id, date)
    distance = 0
    time = 0
    num_rides = 0
    for ride in rides
      distance += ride.distance
      time += ride.movingTime
    end
    if distance > 0
      return (distance/time)*2.2356
    else
      return 0.0
    end
  end

   def redirect_to_root #where is your home?
    if User.first == nil
      redirect_to '/users/new'
    elsif Club.first == nil
      redirect_to '/clubs/new'
    else
      redirect_to '/clubs/home' # this should be the only instance of 'redirect_to root_path' in the app
    end
  end
end