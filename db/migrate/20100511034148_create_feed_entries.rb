class CreateFeedEntries < ActiveRecord::Migration
  def self.up
    create_table :feed_entries do |t|
      t.string :name
      t.text :description
      t.string :url
      t.string :price
      t.string :fullprice
      t.string :guid
      t.datetime :published
      t.string :picture
      t.string :home
      t.string :home_url
      t.integer :stock
      t.integer :rank

      t.timestamps
    end
  end

  def self.down
    drop_table :feed_entries
  end
end
