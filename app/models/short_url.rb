class ShortUrl < ApplicationRecord

  CHARACTERS = [*'0'..'9', *'a'..'z', *'A'..'Z'].freeze

  validates :full_url, :presence => true, :url => true

  def short_code
    if self.id.present?
      generate_short_code
    end
  end

  def update_title!
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
