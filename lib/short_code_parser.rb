class ShortCodeParser

  CHARACTERS = [*'0'..'9', *'a'..'z', *'A'..'Z'].freeze

  def self.from_number(number)
    value = ''

    if number / CHARACTERS.length > 0
      value = self.from_number(number / CHARACTERS.length)
    end

    value + CHARACTERS[number % CHARACTERS.length]
  end

  def self.to_number(short_code)
    number = 0

    short_code.each_char do |char|
      number *= CHARACTERS.length
      number += CHARACTERS.index(char)
    end

    number
  end
end
