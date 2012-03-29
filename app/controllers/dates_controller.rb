class DatesController < ApplicationController


  def index
   
   @tweets_per_day = {}
   @total_tweets = 0
   (0..6).to_a.each do |wd|
     @tweets_per_day[wd] = Hash.new(0)
     @tweets_for_day = Tweet.find_all_by_weekday(wd)
     @tweets_per_day[wd][:number] = @tweets_for_day.size
     @tweets_per_day[wd][:name] = Date::DAYNAMES[wd]
     @tweets_for_day.each do |t|
       @tweets_per_day[wd][:average_hour] += t.hour
     end
     @tweets_per_day[wd][:average_hour] = @tweets_per_day[wd][:average_hour] / @tweets_for_day.size
     @total_tweets += @tweets_for_day.size
   end
   @tweets_per_day_array = @tweets_per_day.sort_by {|key,value| value[:average_hour]}

   
   
   @tweets_per_month = {}
   (1..12).to_a.each do |m|
     @tweets_per_month[m] = Hash.new(0)
     @tweets_for_month = Tweet.find_all_by_month(m)
     @tweets_per_month[m][:number] = @tweets_for_month.size
     @tweets_per_month[m][:name] = Date::MONTHNAMES[m]
     @tweets_for_month.each do |t|
       @tweets_per_month[m][:average_hour] += t.hour
     end
     if @tweets_for_month.size != 0
       @tweets_per_month[m][:average_hour] = @tweets_per_month[m][:average_hour] / @tweets_for_month.size
     end
    end
      
    @tweets_per_month_array = @tweets_per_month.sort_by {|key,value| value[:average_hour]}
    
    @own_tweets_per_hour = Hash.new(0)
    @all_tweets_per_hour = Hash.new(0)
    (0..23).to_a.each do |h|
      @own_tweets_per_hour[h] = Tweet.find_all_by_hour_and_retweeted(h,false).size
      @all_tweets_per_hour[h] = Tweet.find_all_by_hour(h).size
    end
    
    
    respond_to do |format|
      format.html
    end
  end
end