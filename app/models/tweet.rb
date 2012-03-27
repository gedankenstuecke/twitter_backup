class Tweet < ActiveRecord::Base
  belongs_to :user
  belongs_to :place
  serialize :coordinates
  
  searchable do
     text :text
     text :tweeted_at
  end  
end