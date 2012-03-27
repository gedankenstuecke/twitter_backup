class CreateUsers < ActiveRecord::Migration
  def self.up
	  create_table :users do |t|
		  t.string :twitter_id, :unique => true
		  t.string :screen_name
		  t.string :name
		  t.string :location
		  t.string :url
		  
		  t.timestamps
	  end
  end

  def self.down
  	drop_table :users
  end
end
