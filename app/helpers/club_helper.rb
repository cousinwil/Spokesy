module ClubHelper
  include SessionsHelper

#Data returned as follows
#data[0] = total miles
#data[1] = commute miles
#data[2] = longest ride
#data[3] = name of athlete with longest ride
	def get_data(rides)
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
  def find_highest(var, date)
    highest = [{"amount" => 0, "name" => ''}, {"amount" => 0, "name" => ''}, {"amount" => 0, "name" => ''}]
    for member in @members
      amount = var.call(member, date)
      name = GlobalData.format_name(member.user_name)
      if amount >= highest[0]['amount']
        highest[2] = highest[1]
        highest[1] = highest[0]
        highest[0] = {"amount" => amount, "name" => name}
      elsif amount >= highest[1]['amount']
        highest[2] = highest[1]
        highest[1] = {"amount" => amount, "name" => name}
      elsif amount > highest[2]['amount']
        highest[2] = {"amount" => amount, "name" => name}
      end
    end
    return highest
  end

      #Finds the total vertical of the given athlete id
  def find_vertical(member, date)
    vert = 0
    for ride in member.rides
      if ride.date > date
        vert += ride.vertical*3.2808399
      end
    end
    return vert
  end

  def get_points(member, date)
    points = 0
    for ride in member.rides
      if ride.date > date
        points += (ride.vertical*3.2808399)/100
        points += ride.distance.to_f*0.000621
      end
    end
    return points.to_i
  end

  def get_average_speed(member, date)
    distance = 0
    time = 0
    for ride in member.rides
      if ride.date > date
        distance += ride.distance
        time += ride.movingTime
      end
    end
    if distance == 0
      return 0.0
    end
    return (distance/time)*2.2356
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