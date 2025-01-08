class DropSolidCacheEntries < ActiveRecord::Migration[6.0]
  def change
    drop_table :solid_cache_entries, if_exists: true
  end
end
