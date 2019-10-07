class ShortCodeParser

  CHARACTERS = [*'0'..'9', *'a'..'z', *'A'..'Z'].freeze

  def self.from_number(number)
    if number <= 0
      raise ArgumentError.new('invalid number')
    end

    value = ''

    if number / CHARACTERS.length > 0
      value = self.from_number(number / CHARACTERS.length)
    end

    value + CHARACTERS[number % CHARACTERS.length]
  end

  def self.to_number(short_code)
    if short_code.empty?
      raise ArgumentError.new('invalid code')
    end

    number = 0

    short_code.each_char do |char|
      char_index = CHARACTERS.index(char)

      if char_index.nil?
        raise ArgumentError.new('invalid code')
      end

      number *= CHARACTERS.length
      number += char_index
    end

    number
  end
end
