class UsersController < ApplicationController

  def index
    
    @retweets = Tweet.find_all_by_retweeted(true)
    @most_retweeted = Hash.new(0)
    
    @retweets.each do |r|
      @most_retweeted[r.user] += 1
    end
    
    @most_retweeted_array = @most_retweeted.sort_by {|k,v| v}.reverse
    
    @replies = Tweet.where("tweets.in_reply_to_user_id IS NOT NULL")
    
    @most_replied = Hash.new(0)
    
    @replies.each do |r|
      @most_replied[User.find_by_twitter_id(r.in_reply_to_user_id)] += 1
    end
    
    @most_replied_array = @most_replied.sort_by {|k,v| v}.reverse
    
    respond_to do |format|
      format.html
      format.xml 
    end
  end
  
end