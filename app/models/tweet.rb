class Tweet < ActiveRecord::Base
  attr_accessible :body, :tweet
  
  def self.pull
    tweets = Twitter.user_timeline(Club.first.twitter).first(10)
    ids = Tweet.currentIds
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

  def self.currentIds
    ids = []
    for tweet in Tweet.all
      ids.push(tweet.tweet)
    end
    return ids
  end

  def self.bodyWithLink(text)
    pieces = []
    if text.downcase.include?("http://")
      index = text.index('http://')
      pieces[0] = text.slice!(0..(index-1))
      pieces[1] = text.split(' ')[0]
      pieces[2] = text.delete(pieces[1])
      return pieces
    else
      return text
    end
  end
end
