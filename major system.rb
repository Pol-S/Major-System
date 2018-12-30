
class MajorSystem
  MAJOR = {
    '0' => 'S',
    '1' => 'T',
    '2' => 'N',
    '3' => 'M',
    '4' => 'R',
    '5' => 'L',
    '6' => 'SH',
    '7' => 'K',
    '8' => 'V',
    '9' => 'P'
  }
# get the number
  def intake_original_number(seed_number)
    # turn it into a string
    string_number = seed_number.to_s
    # converting it into an array
    numbers_array = string_number.split('')
    # split the string into chunks of 3   
    # tuples is finite ordered list
    tuples = numbers_array.each_slice(3).to_a
       
    # iterate over each chunk of 3 and process it into a word separately
    words = tuples.map do |tuple|
      translate_numbers(tuple)
    end
    puts words
    
    # identify the last chunk (because it could be 1 or 2 or 3) and handle that case separately
  end

  # actually process the hash
  def translate_numbers(tuple)
    tuple.map do |char|
      MAJOR[char]
    end.join
  end
end
