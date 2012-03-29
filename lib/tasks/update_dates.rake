namespace :tweets do
  desc "update tweet-dates"
  task :update_dates => :environment do
   @tweets = Tweet.find(:all)
   @tweets.each do |t|
     t.weekday = t.tweeted_at.wday
     t.day = t.tweeted_at.day
     t.month = t.tweeted_at.month
     t.year = t.tweeted_at.year
     t.hour = t.tweeted_at.hour
     if t.save
       puts "saved "+t.id.to_s
     end
    end
  end
end