class WordList
  def self.dictionary
    @dictionary ||= begin
      words_string = IO.read('words.txt')
      dictionary = words_string.split("\n")
    end
  end
end