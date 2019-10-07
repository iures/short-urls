class ShortUrl < ApplicationRecord

  validates :full_url, :presence => true, :url => true

  after_save :update_title_later

  def self.find_by_short_code(short_code)
    id = ShortCodeParser.to_number(short_code)
    ShortUrl.find_by_id(id)
  end

  def short_code
    if self.id.present?
      ShortCodeParser.from_number(self.id)
    end
  end

  def update_title_later
    UpdateTitleJob.perform_later(self.id)
  end

  def update_title!
    regexp = /<title>(.*?)<\/title>/

    response = fetch_title(self.full_url)

    if matches = response.body.match(regexp)
      self.update_column(:title, matches[1])
    end
  end

  private

  def fetch_title(uri_str, limit = 5)
    raise ArgumentError, 'HTTP redirect too deep' if limit == 0

    response = Net::HTTP.get_response(URI.parse(uri_str))

    if response.code == "301"
      response = fetch_title(response.header['location'], limit - 1)
    end

    response
  end

end
