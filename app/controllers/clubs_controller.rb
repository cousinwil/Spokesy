class ClubsController < ApplicationController
  include ClubHelper

  def home
    @rides = Ride.all
    @rides_this_month = Ride.where("date > ?", (Date.today - 28))
    @members = Member.all
    @events = Event.all
    puts "Club: " + (params || 'empty').to_s

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
  		Delayed::Job.enqueue(RideJob.new, 0, 2.minutes.from_now)
  	end

    @tweets = Tweet.find(:all)
  end

  def create
    @club = Club.new(params[:club])
    respond_to do |format|
      if @club.save
        format.html { redirect_to root_path, notice: 'WORKED' }
        flash[:success] = "Welcome to the club!"
      else
        format.html { redirect_to(root_path(:club => params["club"])) }
        flash[:error] = "Oops! There was an error creating your account."
      end
    end
  end

  def new
    @title = 'Create Club' 
    @club = Club.new
  end

  def confirmed
  end

  def thanks
  end

  def index
    redirect_to root_path
  end

  def update
    @club = Club.find(params[:id])
    puts "CLUB!! " + (params[:club] || 'empty').to_s
    respond_to do |format|
        if @club.update_attributes(params[:club])
          format.html { redirect_to root_path, notice: 'WORKED' }
        else
          puts "DIDN'T SAVE'"
          format.html { redirect_to root_path, notice: 'FUCKED' }
        end
    end
  end
end