class AddExpiryToFeedEntry < ActiveRecord::Migration
  def self.up
    add_column :feed_entries, :expiry, :string
  end

  def self.down
    remove_column :feed_entries, :expiry
  end
end
