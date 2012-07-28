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
  has_many :rides

  validates :user_name, presence: true, length: { maximum: 50 }
  validates :strava_id, presence: true
end

