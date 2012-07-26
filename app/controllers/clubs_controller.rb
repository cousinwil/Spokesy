class ClubsController < ApplicationController
  include ClubHelper

  def home
    @rides = Ride.all
    @members = Member.all 
    if Club.first
      @club = Club.first
    end
  	if Delayed::Job.all.empty?
  		Delayed::Job.enqueue(RideJob.new)
  	end
    @tweets = Tweet.find(:all)
  end

  def create
    @club = Club.new(params[:club])
    respond_to do |format|
      if @club.save
        redirect_to root_path
        flash[:success] = "Welcome to the club!"
      else
        render 'new'
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
    respond_to do |format|
        if @club.update_attributes(params[:club])
          format.html { redirect_to root_path, notice: 'WORKED' }
        else
          format.html { redirect_to root_path, notice: 'FUCKED' }
        end
    end
  end
end