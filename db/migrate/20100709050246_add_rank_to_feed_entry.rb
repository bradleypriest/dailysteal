class AddRankToFeedEntry < ActiveRecord::Migration
  def self.up
    add_column :feed_entries, :rank, :integer
  end

  def self.down
    remove_column :feed_entries, :rank
  end
end
