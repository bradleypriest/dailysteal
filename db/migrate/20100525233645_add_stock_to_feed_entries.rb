class AddStockToFeedEntries < ActiveRecord::Migration
  def self.up
    add_column :feed_entries, :stock, :int
  end

  def self.down
    remove_column :feed_entries, :stock
  end
end
