class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :head_user
  helper_method :maps_api_key
  
  private
  
  def head_user
    head_user = JSON.parse(File.read(::Rails.root.to_s+"/twitter_credentials.json"))["user"]
    head_user
  end
  
  def maps_api_key
    maps_api_key = JSON.parse(File.read(::Rails.root.to_s+"/twitter_credentials.json"))["maps_api_key"]
    maps_api_key
  end
end
