class AdminController < ApplicationController

  before_filter :admin_required
  
  def index
    @events = Event.all

    if Club.first
      @club = Club.first
    else
      @club = Club.new(params[:club])
    end

    @club.events.build

    if User.first == nil
      @user = User.new(params[:user])
    end

  	if ((Delayed::Job.all.empty?) && (Club.first))
  		Delayed::Job.enqueue(RideJob.new, 0, 1.minutes.from_now)
  	end

    @tweets = Tweet.find(:all)
  end
end
