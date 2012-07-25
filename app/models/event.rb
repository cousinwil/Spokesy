class Event < ActiveRecord::Base
  attr_accessible :date, :description, :miles, :name

  def self.next_event
    recent = []
    recent[0] = Event.difference(nil)
    recent[1] = Event.difference(recent[0])
    return recent
  end

  def self.difference(pevent)
    events = Event.all
    correct_date = Date.today + 10000
    correct_event = nil
    events.each do |event|
      if ((event) && (event.date) && (event.date >= Date.today) && (event.date < correct_date) && (event != pevent))
        correct_date = event.date
        correct_event = event
      end
    end
    return correct_event
  end


end
