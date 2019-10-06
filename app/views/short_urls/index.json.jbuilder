json.urls @urls do |short_url|
  json.title short_url.title
  json.full_url short_url.full_url
  json.short_code short_url.short_code
  json.click_count short_url.click_count
end
