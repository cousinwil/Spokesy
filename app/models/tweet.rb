class Tweet < ActiveRecord::Base
  attr_accessible :body, :tweet

  def self.pull
  	tweet = Twitter.user_timeline(GlobalData.find(:first, :conditions => ['name = ?', 'twitter']).value).first
    if ( !(Tweet.last) || !(Tweet.last.tweet.include?(tweet.id.to_s)))
  	  newtweet = Tweet.new(:body => tweet.text, :tweet => tweet.id)
  	  newtweet.save
  	  if Tweet.all.length > 10
  		  oldtweet = Tweet.delete.first
      end
    end
  end
end
