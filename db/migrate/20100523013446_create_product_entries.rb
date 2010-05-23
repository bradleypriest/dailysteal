class CreateProductEntries < ActiveRecord::Migration
  def self.up
    create_table :product_entries do |t|
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

      t.timestamps
    end
  end

  def self.down
    drop_table :product_entries
  end
end
