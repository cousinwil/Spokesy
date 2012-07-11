class SessionsController < ApplicationController

	include SessionsHelper

  def new
  end

  def create
    person = User.find_by_email(params[:session][:email])
    if person && person.authenticate(params[:session][:password])
      sign_in person
      flash[:success] = 'SUCCESS'
      redirect_to root_path
    else
      flash[:error] = 'Invalid email/password combination'
      render 'new'
    end
  end

  def destroy
    sign_out
    redirect_to root
  end

end