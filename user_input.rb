class UserInput
  def self.request_input
    user_number = gets.strip
    formatted_input = format_input(user_number)
    if !correct_format?(formatted_input) 
      puts 'Please input a number.' 
      return request_input      
    end
    formatted_input   
  end

  def self.format_input(user_number)
    user_number.gsub(/[\.\,\s]/, '')
  end

  def self.correct_format?(formatted_input)
    formatted_input.scan(/\D/).empty?
  end
end