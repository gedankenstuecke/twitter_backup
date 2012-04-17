namespace :tweets do
  desc "get tweets"
  task :get => :environment do
    file_handle= File.read(::Rails.root.to_s+"/twitter_credentials.json")
    credentials = JSON.parse(file_handle)
    
    @tweets =Twitter.user_timeline(credentials["user"],:count => 200,:include_rts => 1)
    
    # iterate over all tweets grabbed in this run
    
    @tweets.each do |t|
      puts "---"
      puts "started with tweet "+t.id.to_s
      
      if t.retweeted_status != nil    # check if tweet is a retweet, if yes: grab original tweet
        @tweet_at_twitter = t.retweeted_status
        @user_at_twitter = t.retweeted_status.user
      else
        @tweet_at_twitter = t   # else keep tweet grabbed through api
        @user_at_twitter = t.user
      end
        
      if Tweet.find_by_twitter_id(@tweet_at_twitter.id) == nil # check if tweet already exists in database
        
        if @tweet_at_twitter.place != nil # check if location is attached to tweet
          if Place.find_by_twitter_id(@tweet_at_twitter.place.id) == nil # check if location already exists in database 
            @place = Place.new()
            @place.twitter_id = @tweet_at_twitter.place.id
            @place.full_name = @tweet_at_twitter.place.full_name
            begin
              @place.coordinates = @tweet_at_twitter.place.bounding_box.coordinates
            rescue
              @place.coordinates = nil
            end
            @place.save
            puts "saved place "+@place.twitter_id.to_s
          end
        end
        
        # check for user and create if necessary
        
        if User.find_by_twitter_id(@user_at_twitter.id) == nil
          @user = User.new()
          @user.twitter_id = @user_at_twitter.id
          @user.screen_name = @user_at_twitter.screen_name
          @user.name = @user_at_twitter.name
          @user.location = @user_at_twitter.location
          @user.url = @user_at_twitter.url
          @user.avatar_from_url(@user_at_twitter.profile_image_url)
          @user.save
          puts "created user "+@user.twitter_id.to_s
        end
        
        @tweet = Tweet.new()
        @tweet.twitter_id = @tweet_at_twitter.id
        @tweet.text = @tweet_at_twitter.text
        if t.retweeted == true
          @tweet.retweeted = true
          @tweet.retweeted_at = t.created_at
        else
          @tweet.retweeted = false
        end
        @tweet.tweeted_at = @tweet_at_twitter.created_at
        @tweet.source = @tweet_at_twitter.source
        @tweet.in_reply_to_user_id = @tweet_at_twitter.in_reply_to_user_id
        @tweet.in_reply_to_status_id = @tweet_at_twitter.in_reply_to_status_id
        
        @tweet.weekday = @tweet_at_twitter.created_at.wday
        @tweet.day = @tweet_at_twitter.created_at.day
        @tweet.month = @tweet_at_twitter.created_at.month
        @tweet.year = @tweet_at_twitter.created_at.year
        @tweet.hour = @tweet_at_twitter.created_at.hour
        
        if @tweet_at_twitter.in_reply_to_user_id != nil
          if User.find_by_twitter_id(@tweet_at_twitter.in_reply_to_user_id) == nil
            @reply_user = Twitter.user(@tweet_at_twitter.in_reply_to_user_id)
            @user = User.new()
            @user.twitter_id = @reply_user.id
            @user.screen_name = @reply_user.screen_name
            @user.name = @reply_user.name
            @user.location = @reply_user.location
            @user.url = @reply_user.url
            @user.avatar_from_url(@reply_user.profile_image_url)
            @user.save
            puts "created user "+@user.twitter_id.to_s+" to reply to"
          end
        end
        
        begin
          @tweet.coordinates = @tweet_at_twitter.geo.coordinates
          @tweet.geo_data = true
        rescue
          @tweet.geo_data = false
        end
        
        @tweet.user_id = User.find_by_twitter_id(@user_at_twitter.id).id
        if @tweet_at_twitter.place != nil
          @tweet.place_id = Place.find_by_twitter_id(@tweet_at_twitter.place.id).id
          puts "saved geo-location!"
        end
        @tweet.save
        puts "saved tweet "+@tweet_at_twitter.id.to_s
      else
        puts "old tweet, did not save "+@tweet_at_twitter.id.to_s
      end
    end
  end
end
