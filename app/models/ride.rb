class Ride < ActiveRecord::Base
  attr_accessible :athlete, :commute, :distance, :points, :speed, :vertical, :ride_id, :date, :name

  def self.allIds
  	ids = []
  	for ride in Ride.all
  		ids.push(ride.ride_id)
  	end
    return ids
  end

  #Returns the list of unique athlete ids
  def self.getRiders
    riders = []
    for ride in Ride.all
      if !(riders.include? ride.name)
        riders.push(ride.name)
      end
    end
    return riders
  end

  #Finds the total vertical of the given athlete id
  def self.findVert(rider_name)
    rides = Ride.where('name = ?', rider_name)
    vert = 0
    for ride in rides
      vert += ride.vertical
    end
    return vert
  end

  #Returns the three highest vertical values and the respective names
  #Display as follows
  #1st highest[3] - highest[0]
  #2nd highest[4] - highest[1]
  #3rd highest[5] - highest[2]
  def self.findHighestVert
    riders = getRiders
    highest = [0, 0, 0, '', '', '']
    for rider in riders
      vert = findVert(rider)
      if vert >= highest[0]
        highest[2] = highest[1]
        highest[5] = highest[4]
        highest[1] = highest[0]
        highest[4] = highest[3]
        highest[3] = rider
        highest[0] = vert
      elsif vert >= highest[1]
        highest[2] = highest[1]
        highest[5] = highest[4]
        highest[1] = vert
        highest[4] = rider
      elsif vert > highest[2]
        highest[2] = vert
        highest[5] = rider
      end
    end
    return highest
  end
end
