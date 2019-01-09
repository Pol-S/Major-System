require './user_input'
require './word_list'
require 'pry'

class MajorSystem
  MAJOR = {
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

  def ask
    puts 'Hi. What long number do you want to convert into words?'
    formatted_input = UserInput.request_input 
    translate_input(formatted_input)
  end

  private

  def translate_input(formatted_input)
    #put it in an array
    number_array = formatted_input.split('')
    #slice the array into chunks of 3
    chunks = number_array.each_slice(3).to_a
    #call translate
    chunks.map {|tuple| translate(tuple)}     
  end

  def translate(tuple)
    #get an array of arrays
    letter_choices = tuple.map { |number| MAJOR[number] }
    #take the first array out of the larger array
    first_set = letter_choices.shift
    letter_choices << ['END'] if letter_choices.empty?
    #starting with the first array as our base case, we do the x.product(y)...
    #process across the entire board.
    #inject maintains state beteween each element of the iteration, continuously
    #building up the greater set of combinations
    translated_tuples = letter_choices.inject(first_set) do |combination, choices|
      combination.product(choices)
    end
    # we smoosh it down so we don't have a jagged array
    translated_tuples = translated_tuples.map(&:flatten)
    fetch_candidate(translated_tuples.shuffle)
  end

  def fetch_candidate(translated_tuples)
    return 'ERROR' if translated_tuples.empty? 
    consonants = make_consonants_pattern(translated_tuples.first)
    word_candidate = get_word_candidate(consonants)
    if word_candidate.nil?
      translated_tuples.shift
      return fetch_candidate(translated_tuples.shuffle)
    end
    word_candidate
  end
  
  def make_consonants_pattern(translated_tuples)
    letter_string = '^'
    translated_tuples.each do |value|
      letter_string << value
      letter_string << '.+'
    end
    letter_string.chop!.chop!
    letter_string << '$'
    # Actually turning it into a regex
    Regexp.new(letter_string.downcase)
  end
  
  def get_word_candidate(consonants)
    candidates = WordList.dictionary.select do |word| 
      word =~ consonants 
    end
    candidates.sample
  end
end




test = MajorSystem.new
test.ask