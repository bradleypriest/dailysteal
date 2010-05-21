class RemoveExpiryFromFeedEntry < ActiveRecord::Migration
  def self.up
    remove_column :feed_entries, :expiry
  end

  def self.down
    add_column :feed_entries, :expiry, :string
  end
end
