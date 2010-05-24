class AddRankToFeedEntries < ActiveRecord::Migration
  def self.up
    add_column :feed_entries, :rank, :int
  end

  def self.down
    remove_column :feed_entries, :rank
  end
end
