class ShortUrl < ApplicationRecord

  CHARACTERS = [*'0'..'9', *'a'..'z', *'A'..'Z'].freeze

  validates :full_url, :presence => true, :url => true

  before_create :generate_short_code

  def generate_short_code
    self.short_code = CHARACTERS.sample(3) #temporary
  end

  private

  def update_title!
  end

end
