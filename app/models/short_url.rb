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
    title = PageScraper.new(self.full_url).extract_tag('title')

    if title.present?
      self.update_column(:title, title)
    end
  end

end
