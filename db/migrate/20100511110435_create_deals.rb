class CreateDeals < ActiveRecord::Migration
  def self.up
    create_table :deals do |t|
      t.string :title
      t.string :description
      t.string :site
      t.string :price
      t.string :fullprice

      t.timestamps
    end
  end

  def self.down
    drop_table :deals
  
  end
end
