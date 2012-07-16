class ClubController < ApplicationController
  include StravaHelper
  include SessionsHelper
  include ClubHelper

  def home
  end
end