class ClubController < ApplicationController
  include ClubHelper


  def home
    findRides
  end
    
  def confirmed
  end

  def thanks
  end

  def deliver
    Delayed::Job.enqueue(RideJob.new())
  end
end