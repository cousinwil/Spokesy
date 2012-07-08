class ClubController < ApplicationController
  include StravaHelper

  def home
    get_data(5493, 365)
  end
end