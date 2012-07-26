class UsersController < ApplicationController

  #before_filter :admin_required # Just for now while users aren't supported

  def new
  	@title = 'Sign Up'
  	@user = User.new(params[:user])
    respond_to do |format|
      format.html
      format.json {render json: @user}
    end
  end

  def create
    @user = User.new(params[:user])
    respond_to do |format|
  	  if @user.save
        redirect_to root_path
        flash[:success] = "Welcome to the club!"
      else
        render 'new'
        flash[:error] = "Oops! There was an error creating your account."
      end
    end
  end

  def show
    @user = User.find(params[:id])
  	@title = "#{@user.name}'s Profile"
  end
end
