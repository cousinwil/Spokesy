class Tweet < ActiveRecord::Base
  attr_accessible :body, :tweet
  
  def self.pull
    tweets = Twitter.user_timeline(Club.first.twitter).first(10)
    ids = Tweet.current_ids
    for tweet in tweets
      if ( !(ids.include?(tweet.id.to_s)) )
        newtweet = Tweet.new(:body => tweet.text, :tweet => tweet.id)
        newtweet.save
        if Tweet.all.length > 10
          Tweet.delete(Tweet.first)
        end
      end
    end
  end

  def self.current_ids
    ids = []
    for tweet in Tweet.all
      ids.push(tweet.tweet)
    end
    return ids
  end
end
