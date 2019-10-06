class ShortUrl < ApplicationRecord

  CHARACTERS = [*'0'..'9', *'a'..'z', *'A'..'Z'].freeze

  validates :full_url, :presence => true, :url => true

  after_save :update_title_later

  def short_code
    if self.id.present?
      generate_short_code
    end
  end

  def self.find_by_short_code(short_code)
    id = 0

    short_code.each_char do |char|
      id *= CHARACTERS.length
      id += CHARACTERS.index(char)
    end

    ShortUrl.find_by(id: id)
  end

  def update_title_later
    UpdateTitleJob.perform_later(self.id)
  end

  def update_title!
    regexp = /<title>(.*?)<\/title>/
    response = Faraday.get(self.full_url)

    if matches = response.body.match(regexp)
      self.update_column(:title, matches[1])
    end
  end

  private

  def generate_short_code
    map_number_to_characters(self.id)
  end

  def map_number_to_characters(number)
    value = ''

    if number / CHARACTERS.length > 0
      value = map_number_to_characters(number / CHARACTERS.length)
    end

    value + CHARACTERS[number % CHARACTERS.length]
  end

end
