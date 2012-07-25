# == Schema Information
#
# Table name: users
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  email      :string(255)
#  created_at :datetime        not null
#  updated_at :datetime        not null

class Member < ActiveRecord::Base
  attr_accessible :strava_id, :user_name, :user_id, :club_id

  belongs_to :user

  validates :user_name, presence: true, length: { maximum: 50 }
  validates :strava_id, presence: true

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
        Member.create([{ user_name: athlete_name.to_s, strava_id: athlete_id.to_i }])
      end
    end
  end
end

