class AddDjRemixesColumns < ActiveRecord::Migration
  def self.up
    add_column :delayed_jobs, :worker_class_name,   :string
    add_column :delayed_jobs, :started_at,          :datetime
    add_column :delayed_jobs, :finished_at,         :datetime
  end

  def self.down
    remove_column :delayed_jobs, :worker_class_name
    remove_column :delayed_jobs, :started_at
    remove_column :delayed_jobs, :finished_at
  end
end