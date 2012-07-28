class Club < ActiveRecord::Base
  attr_accessible :club_id, :name, :twitter, :email_list, :home_headline, :about_headline, :about_body, :home_quote, :email_list, :mail_list_desc

  validate :validate_club_id
  validates :name, presence: true

  #Adds all members belong to club passed in to database
  def self.get_members(club_id, helper)
    strava_api = helper
    #Spoke Geek club_id = 5493
    member_details = strava_api.get("clubs/#{club_id}/members")
    athlete_name = 0
    athlete_id = 0

    member_details['members'].each do |member|
      athlete_name = member['name'].to_s
      athlete_id = member['id'].to_i
      puts 'NAME: ' + member['name'].to_s
      member = Member.find(:first, :conditions => ["strava_id='#{athlete_id}'"])
      unless member
        Member.create([{ user_name: athlete_name.to_s, strava_id: athlete_id.to_i, club_id: club_id }])
      end
    end
  end

  private

  def check_club_id
    strava_api = StravaApiHelper["www.strava.com"]
    if strava_api.get("clubs/#{self.club_id}/members")["members"]
      return true
    else
      return false
    end
  end

  def validate_club_id
    errors.add("Club id", "is invalid.") unless check_club_id
  end
end
