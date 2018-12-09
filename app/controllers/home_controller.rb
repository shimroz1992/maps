class HomeController < ApplicationController
  before_action :authenticate_user!
  def index
    @locations = current_user.both_locations
    @hash = Gmaps4rails.build_markers(@locations) do |location, marker|
      marker.infowindow location.address
      marker.lat location.latitude
      marker.lng location.longitude
    end
  end

  def public_share
    @user = User.find_by_username(params['username']) if params["username"].present?
    if @user.present?
      @locations = @user.public_shared
      @hash = Gmaps4rails.build_markers(@locations) do |location, marker|
        marker.infowindow location.address
        marker.lat location.latitude
        marker.lng location.longitude
      end
    else
      flash[:danger]= "No public shared locations found."
    end
  end
end
