class TweetsController < ApplicationController

helper_method :sort_column, :sort_direction

  def index
    @user = JSON.parse(File.read(::Rails.root.to_s+"/twitter_credentials.json"))["user"]
    @tweets = Tweet.order(sort_column + " " + sort_direction)
    @tweets_paginate = @tweets.paginate(:page => params[:page],:per_page => 20)
    respond_to do |format|
      format.html
      format.xml 
    end
  end
  
  
  private
  
  def sort_column
    Tweet.column_names.include?(params[:sort]) ? params[:sort] : "tweeted_at"
  end

  def sort_direction
    %w[desc asc].include?(params[:direction]) ? params[:direction] : "desc"
  end
end