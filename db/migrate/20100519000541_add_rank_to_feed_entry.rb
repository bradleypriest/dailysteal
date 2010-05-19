class AddRankToFeedEntry < ActiveRecord::Migration
  def self.up
    add_column :feed_entries, :role, :int
  end

  def self.down
    remove_column :feed_entries, :role
  end
end
