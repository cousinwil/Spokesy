class Event < ActiveRecord::Base
  attr_accessible :date, :description, :miles, :name

  def self.next_event
  	events = Event.all
    correct_date = Date.today + 10000
    correct_event = Event.first
  	if events
  		events.each do |event|
  			if ((event) && (event.date) && (event.date >= Date.today) && (event.date < correct_date))
          correct_date = event.date
          correct_event = event
        end
      end
    end
    return correct_event
  end

end
