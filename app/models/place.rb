class Place < ActiveRecord::Base
  has_many :tweets
  has_many :users, :through => :tweets
  serialize :coordinates
  
  searchable do
     text :full_name
  end
  
end