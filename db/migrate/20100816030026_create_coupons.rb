class CreateCoupons < ActiveRecord::Migration
  def self.up
    create_table :coupons do |t|
        t.string :name
        t.text :description
        t.string :url
        t.string :price
        t.string :guid
        t.datetime :published
        t.string :picture
        t.string :home
        t.string :home_url
        t.integer :location_id
        t.integer    :stock
        t.integer    :rank
      t.timestamps
    end
  end

  def self.down
    drop_table :coupons
  end
end
