class CreateFeedEntries < ActiveRecord::Migration
  def self.up
    create_table :feed_entries do |t|
      t.string :name
      t.text :description
      t.string :url
      t.string :price
      t.string :fullprice
      t.string :guid

      t.timestamps
    end
  end

  def self.down
    drop_table :feed_entries
  end
end
