require './word_list'
require 'pry'

class MajorSystem
  attr_accessor :digit_string, :mnemonic_words

  CONSONANTS_BY_DIGIT = {
    '0' => ['S','Z'],
    '1' => ['D', 'T', 'TH'],
    '2' => ['N'],
    '3' => ['M'],
    '4' => ['R'],
    '5' => ['L'],
    '6' => ['CH', 'J', 'SH'],
    '7' => ['G', 'K'],
    '8' => ['F', 'PH', 'V'],
    '9' => ['B', 'P']                           
  }

  def initialize(digit_string)
    translate(digit_string)
  end

  def translate(digit_string)
    formatted_string = format_input(digit_string)
    raise ArgumentError.new 'Not all digits' if !correct_format?(formatted_string)
    @digit_string = formatted_string    
    @mnemonic_words = translate_formatted_string(digit_string) if correct_format?(@digit_string)
  end

  private

  def translate_formatted_string(digit_string)
    # '1234567' -> ['1', '2', '3', '4', '5', '6', '7']
    digit_set = digit_string.split('')
    # [['1', '2', '3'], ['4', '5', '6'], ['7']]
    digit_sets = digit_set.each_slice(3).to_a
    digit_sets.map do |digits| 
      translate_to_mnemonic_word(digits)
    end     
  end

  def format_input(digit_string)
    digit_string.gsub(/[\.\,\s]/, '')
  end

  def correct_format?(formatted_string)
    formatted_string.scan(/\D/).empty?
  end

  def translate_to_mnemonic_word(digits)
    consonant_sets = digits.map { |digit| CONSONANTS_BY_DIGIT[digit] }
    consonant_combos = create_consonant_combos(consonant_sets)
    find_mnemonic_word(consonant_combos)
  end

  def create_consonant_combos(consonant_sets)
    first_set = consonant_sets.shift
    consonant_sets << ['END'] if consonant_sets.empty?
    consonant_combos = consonant_sets.inject(first_set) do |combination, set|
      combination.product(set)
    end
    consonant_combos.map(&:flatten)
  end

  def find_mnemonic_word(consonant_combos)
    consonant_combos = consonant_combos.shuffle
    return 'ERROR' if consonant_combos.empty? 
    consonants_pattern = create_consonants_pattern(consonant_combos.first)
    matched_word = match_word(consonants_pattern)
    return find_mnemonic_word(consonant_combos[1..-1]) if matched_word.nil?
    matched_word
  end
  
  def create_consonants_pattern(consonant_combos)
    pattern = '^'
    consonant_combos.each do |value|
      pattern << value
      pattern << '.+'
    end
    pattern.chop!.chop!
    pattern << '$'
    Regexp.new(pattern.downcase)
  end
  
  def match_word(consonants)
    candidates = WordList.dictionary.select do |word| 
      word =~ consonants 
    end
    candidates.sample
  end
end