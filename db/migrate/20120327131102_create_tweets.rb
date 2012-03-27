class CreateTweets < ActiveRecord::Migration
  def self.up
	  create_table :tweets do |t|
		  t.string :twitter_id, :unique => true
		  t.string :text
		  t.boolean :retweeted
		  t.timestamp :retweeted_at
		  t.timestamp :tweeted_at
		  t.string :source
		  t.string :in_reply_to_user_id
      t.string :in_reply_to_status_id
      t.boolean :geo_data
      t.string :coordinates
      
      t.belongs_to :user
      t.belongs_to :place
      
      t.timestamps
	  end
  end

  def self.down
  	drop_table :tweets
  end
end
