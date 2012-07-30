class Event < ActiveRecord::Base
  attr_accessible :date, :description, :miles, :name, :club_id

  belongs_to :club

  validate :validate_date
  validates :name, presence: true, length: { maximum: 50 }
  validates :miles, presence: true
  validates :description, presence: true, length: { maximum: 200 }

  def self.next_events(number)
    recent = []
    (0..(number-1)).each do |i|
      recent[i] = Event.next_event(recent)
    end
    return recent
  end

  def self.next_event(reference)
    events = Event.all
    next_event_date = Date.today + 10000 #A date which is hopefully after the most recent event
    event_following_reference = nil

    events.each do |event|
      if ((event.date >= Date.today) && (event.date < next_event_date) && !(reference.include?(event)))
        next_event_date = event.date
        event_following_reference = event
      end
    end

    return event_following_reference
  end

  private

  def convert_date
    begin
      self.date = Date.civil(self.date.year.to_i, self.date.month.to_i, self.date.day.to_i)
    rescue ArgumentError
      false
    end
  end

  def validate_date
    errors.add("Created at date", "is invalid.") unless convert_date
  end
end
