class Club < ActiveRecord::Base
  attr_accessible :club_id, :name, :twitter, :email_list
end
