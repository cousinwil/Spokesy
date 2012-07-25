class ClubController < ApplicationController
  include ClubHelper

  def home
    @rides = Ride.all
    @members = Member.all
  	if Delayed::Job.all.empty?
  		Delayed::Job.enqueue(RideJob.new)
  	end

    @tweets = Tweet.find(:all)
  end
    
  def confirmed
  end

  def thanks
  end
end