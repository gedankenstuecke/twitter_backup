class PlacesController < ApplicationController

helper_method :sort_column, :sort_direction

  def index
    
    @places = Place.find(:all)
    @counted_places = Hash.new(0)
    @places.each do |p|
      @counted_places[p] = p.tweets.size
    end
    @counted_places_array = @counted_places.sort_by{ |k,v| v }.reverse

    respond_to do |format|
      format.html
      format.xml 
    end
  end
  
  
  def show
    @place = Place.find_by_id(params[:id])
    @tweets = Tweet.where("place_id = ?",params[:id]).order("tweeted_at DESC").limit(20)
    @users = @place.users
    @user_hash = Hash.new(0)
    @users.each do |u|
      @user_hash[u] += 1
    end
    @user_array = @user_hash.sort_by {|k,v| v}.reverse
    
    @mean_lat = 0
    @mean_long = 0
    @place.coordinates[0].each do |u|
      @mean_lat += u[1]
      @mean_long += u[0]
    end
    
    @mean_lat = @mean_lat / @place.coordinates[0].size
    @mean_long = @mean_long / @place.coordinates[0].size
    
    respond_to do |format|
      format.html
    end
  end
  
  private
  
  def sort_column
    Places.column_names.include?(params[:sort]) ? params[:sort] : "created_at"
  end

  def sort_direction
    %w[desc asc].include?(params[:direction]) ? params[:direction] : "desc"
  end
end