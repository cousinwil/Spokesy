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
    puts 'USER: ' + (params[:user] || 'NIL').to_s
    respond_to do |format|
      @user.admin = true
  	  if @user.save
        format.html { redirect_to root_path, notice: 'WORKED' }
        flash[:success] = "Welcome to the club!"
      else
        format.html { redirect_to(root_path(:user => params[:user])) }
        flash[:error] = "Oops! There was an error creating your account."
      end
    end
  end

  def index
    redirect_to root_path
  end

  def update
    @user = User.new(params[:user])
    respond_to do |format|
      @user.update_attributes(params[:user])
      format.html { redirect_to root_path }
    end
  end

  def show
    @user = User.find(params[:id])
  	@title = "#{@user.name}'s Profile"
  end
end
