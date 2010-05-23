class AddRankToProductEntries < ActiveRecord::Migration
  def self.up
    add_column :product_entries, :rank, :string
  end

  def self.down
    remove_column :product_entries, :rank
  end
end
