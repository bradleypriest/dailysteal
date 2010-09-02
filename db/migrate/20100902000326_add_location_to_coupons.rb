class AddLocationToCoupons < ActiveRecord::Migration
  def self.up
    add_column :coupons, :location, :string
  end

  def self.down
    remove_column :coupons, :location
  end
end
