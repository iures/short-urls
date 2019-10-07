require 'spec_helper'
require 'short_code_parser'

RSpec.describe ShortCodeParser do

  describe ".from_number" do

    context "with an invalid number" do
      
      it "raises for negative numbers" do
        expect { ShortCodeParser.from_number(-1) }.to raise_error(ArgumentError, 'invalid number')
      end

      it "raises for the zero number" do
        expect { ShortCodeParser.from_number(0) }.to raise_error(ArgumentError, 'invalid number')
      end

    end

    it "returns the smallest corresponding code for small numbers" do
      expect(ShortCodeParser.from_number(1)).to eq('1')
      expect(ShortCodeParser.from_number(61)).to eq('Z')
    end

    it "parses the short code for bigger numbers" do
      expect(ShortCodeParser.from_number(62)).to eq('10')
      expect(ShortCodeParser.from_number(3843)).to eq('ZZ')
      expect(ShortCodeParser.from_number(3844)).to eq('100')
      expect(ShortCodeParser.from_number(238327)).to eq('ZZZ')
    end

  end

  describe ".to_number" do

    context "with an invalid code" do
      
      it "raises for invalid characters" do
        expect { ShortCodeParser.to_number('&') }.to raise_error(ArgumentError, 'invalid code')
        expect { ShortCodeParser.to_number('00*') }.to raise_error(ArgumentError, 'invalid code')
        expect { ShortCodeParser.to_number('a-') }.to raise_error(ArgumentError, 'invalid code')
      end

      it "raises for empty code" do
        expect { ShortCodeParser.to_number('') }.to raise_error(ArgumentError, 'invalid code')
      end

    end

  end

end
