class CreateCoupons < ActiveRecord::Migration
  def self.up
    create_table :coupons do |t|
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
        t.int    :stock
        t.int    :rank
      t.timestamps
    end
  end

  def self.down
    drop_table :coupons
  end
end
