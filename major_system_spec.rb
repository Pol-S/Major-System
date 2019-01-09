require './major_system'

describe MajorSystem do
  describe '#ask' do
    let(:result) { described_class.new.ask }
    let(:formatted_input) { '1234567890' }
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

    before do 
      allow(UserInput).to receive(:request_input).and_return(formatted_input)
      allow(WordList).to receive(:dictionary).and_return(word_list)
    end
    
    it 'found matching words from the English dictionary' do
      expect(result).to eq(expected_outcome)
    end

  end
end