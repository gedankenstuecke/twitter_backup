class AddDatesToTweet < ActiveRecord::Migration
  def self.up
    add_column :tweets, :year, :integer
    add_column :tweets, :month, :integer
    add_column :tweets, :day, :integer
    add_column :tweets, :weekday, :integer
    add_column :tweets, :hour, :integer
  end

  def self.down
    remove_column :tweets, :year, :integer
    remove_column :tweets, :month, :integer
    remove_column :tweets, :day, :integer
    remove_column :tweets, :weekday, :integer
    remove_column :tweets, :hour, :integer
  end
end
