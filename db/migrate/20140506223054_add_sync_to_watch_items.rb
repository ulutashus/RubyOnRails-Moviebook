class AddSyncToWatchItems < ActiveRecord::Migration
  def change
    add_column :watch_items, :sync, :boolean, :default => false
  end
end
