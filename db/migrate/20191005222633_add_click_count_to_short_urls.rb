class AddClickCountToShortUrls < ActiveRecord::Migration[6.0]
  def change
    add_column :short_urls, :click_count, :integer, :default => 0
  end
end
