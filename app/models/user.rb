class User < ActiveRecord::Base
  has_many :tweets
  has_many :places, :through => :tweets
  
  has_attached_file :avatar
  
  require "open-uri"
  def avatar_from_url(url)
    self.avatar = open(url)
  end
  
  searchable do
     text :name
     text :screen_name
     text :url
     text :location
  end
  
end