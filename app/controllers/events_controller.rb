class EventsController < ApplicationController

  before_filter :admin_required
  
  def new
    @event = Event.new(params[:event])
    respond_to do |format|
      format.html # new.html.erb
    end
  end

  def index
  end

  def create
    @event = Event.new(params[:event])
    respond_to do |format|
      if @event.save
        format.html # new.html.erb
      end
    end
  end
end