class AddCityAndPhoneAndDetailsToSignups < ActiveRecord::Migration
  def self.up
    add_column :signups, :city, :string
    add_column :signups, :phone, :string
    add_column :signups, :details, :text
  end

  def self.down
    remove_column :signups, :details
    remove_column :signups, :phone
    remove_column :signups, :city
  end
end
