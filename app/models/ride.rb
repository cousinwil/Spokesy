class Ride < ActiveRecord::Base
  attr_accessible :athlete, :commute, :distance, :points, :speed, :vertical, :ride_id, :date, :name

  def self.allIds
  	ids = []
  	for ride in Ride.all
  		ids.push(ride.ride_id)
  	end
    return ids
  end

    #Finds the total vertical of the given athlete id
  def self.findVert(member)
    rides = Ride.where('athlete = ?', member.id)
    vert = 0
    for ride in rides
      vert += ride.vertical
    end
    return vert
  end

  def self.getPoints(member)
    rides = Ride.where('athlete = ?', member.id)
    points = 0
    for ride in rides
      points += (ride.vertical)/100
      points += ride.distance.to_f*0.000621
    end
    return points.to_i
  end

  def self.getAveSpeed(member)
    rides = Ride.where('athlete = ?', member.id)
    total = 0
    num_rides = 0
    for ride in rides
      num_rides += 1
      total += ride.speed
    end
    if num_rides > 0
      return (total/num_rides)*2.2356
    else
      return 0.0
    end
  end

  def self.highestPts
    return findHighest(method(:getPoints))
  end

  def self.highestVert
    return findHighest(method(:findVert))
  end

  def self.highestAveSpeed
    return findHighest(method(:getAveSpeed))
  end

  def self.saveNewRides(ride_details)
    ride_details.each do |ride|
      puts 'NEW RIDER: ' + ride.to_s
      newRide = Ride.new(:commute => ride['ride']['commute'], 
        :distance => ride['ride']['distance'].to_f,
        :speed => ride['ride']['averageSpeed'].to_f,
        :vertical => ride['ride']['elevationGain'].to_f,
        :name => ride['ride']['athlete']['name'], 
        :date => ride['ride']['startDate'], 
        :ride_id => ride['ride']['id'],
        :athlete => (Member.find_by_strava_id(ride['ride']['athlete']['id'])).id)
      newRide.save
    end
  end
  #Returns the three highest vertical values and the respective names
  #Display as follows
  #1st highest[3] - highest[0]
  #2nd highest[4] - highest[1]
  #3rd highest[5] - highest[2]
  def self.findHighest(var)
    highest = [0, 0, 0, '', '', '']
    for member in Member.all
      amount = var.call(member)
      if amount >= highest[0]
        highest[2] = highest[1]
        highest[5] = highest[4]
        highest[1] = highest[0]
        highest[4] = highest[3]
        highest[3] = member.user_name
        highest[0] = amount
      elsif amount >= highest[1]
        highest[2] = highest[1]
        highest[5] = highest[4]
        highest[1] = amount
        highest[4] = member.user_name
      elsif amount > highest[2]
        highest[2] = amount
        highest[5] = member.user_name
      end
    end
    return highest
  end
end
