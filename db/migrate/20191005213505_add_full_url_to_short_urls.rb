class AddFullUrlToShortUrls < ActiveRecord::Migration[6.0]
  def change
    add_column :short_urls, :full_url, :string
  end
end
