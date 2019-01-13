require './major_system'
require './word_list'
require 'pry'

describe MajorSystem do
  let(:result) { described_class.new(digit_string).mnemonic_words }

  before do 
    allow(WordList).to receive(:dictionary).and_return(word_list)
  end
 
  let(:digit_string) { '1234567890' }
  let(:expected_outcome) { %w[triennium reabolish kerflop solvend] }
  let(:word_list) do
    %w[
      triennium 
      reabolish 
      kerflop 
      solvend
      greg
      garfield
      gary
      gesticulate
      extemporaneous
      rihanna
      beyonce
      mendes               
    ]
  end

  it 'found matching words from the English dictionary' do
    expect(result).to eq(expected_outcome)
  end

  context 'when the received string is not all digits' do
    let(:result) {described_class.new(input)}
    let(:input) { '548ff' }       
    it 'raised Standard Error' do
      expect{result}.to raise_error(ArgumentError, 'Not all digits')
    end    
  end
end