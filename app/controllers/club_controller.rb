class ClubController < ApplicationController
  include ClubHelper

  def home
  	if Delayed::Job.all.empty?
  		Delayed::Job.enqueue(RideJob.new, 0, 15.minutes.from_now)
  	end
  end
    
  def confirmed
  end

  def thanks
  end
end