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

  def initialize
    @dictionary ||= IO.read("words.txt")
    puts 'Hi. What long number do you want to convert into words?'
    request_input 
  end

  private 

  def request_input
    user_number = gets.strip
    formatted_input = format_input(user_number)
    if !correct_format?(formatted_input) 
      puts 'Please input a number.' 
      return request_input      
    end
    translate_input(formatted_input)    
  end

  def format_input(user_number)
    user_number.gsub(/[\.\,\s]/, '')
  end

  def correct_format?(formatted_input)
    character_array = formatted_input.split('')
    character_array.all? do |each_char| 
      #each_char.match?(/[0-9]/)
      each_char =~ /\d/
    end
  end

  def translate_input(formatted_input)
    #put it in an array
    number_array = formatted_input.split('')
    #slice the array into chunks of 3
    chunks = number_array.each_slice(3).to_a
    #call translate
    words = chunks.map {|tuple| translate(tuple)} 
    puts words
  end

  def translate(tuple)   
    # Get a string with the right characters for the regex
    letter_string = '\n'
    tuple.each do |number|
      letter_string << MAJOR[number].sample
      letter_string << '.+'
      end
    # Actually turning it into a regex
    consonants = Regexp.new(letter_string.downcase)
    #now diving into the dictionary for a word with these consonants
    found_words = dictionary_dive(consonants)
  end
  
  def dictionary_dive(consonants)
    #time to actually go into the dictionary
    candidates_string = @dictionary.scan(consonants)
    candidates = candidates_string.to_a
    candidates.sample
  end


end


test=MajorSystem.new