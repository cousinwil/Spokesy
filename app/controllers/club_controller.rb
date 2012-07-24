class ClubController < ApplicationController
  include ClubHelper

  def home
  	if Delayed::Job.all.empty?
  		Delayed::Job.enqueue(RideJob.new)
  	end
  end
    
  def confirmed
  end

  def thanks
  end
end