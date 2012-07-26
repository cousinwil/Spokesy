class Club < ActiveRecord::Base
  attr_accessible :club_id, :name, :twitter, :email_list, :home_headline, :about_headline, :about_body, :home_quote, :email_list, :mail_list_desc
end
