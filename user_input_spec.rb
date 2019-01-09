require './user_input'

describe UserInput do
  describe 'request_input' do 
    let(:result) { described_class.request_input }
    let(:expected_outcome) { '123456789' }
    
    context 'when given a number that can be formatted' do
      let(:user_number) { '123456789' }

      before do
        allow(described_class).to receive(:gets).and_return(user_number)
      end

      it 'returns a string with only digits' do
        expect(result).to eq(expected_outcome)
      end  
    end

    context 'when given a number that can not be formatted' do
      let(:wrong_value) { 'fffffffuuuu' }
      let(:right_value) { '123456789' }

      before do
        allow(described_class).to receive(:gets).and_return(wrong_value, right_value)
      end

      it 'returns a string with only digits' do
        expect(described_class).to receive(:puts).with('Please input a number.')
        expect(result).to eq(expected_outcome)        
      end  
    end
  end

  describe 'format_input' do 
    let(:result) { described_class.format_input(input_number) }
    let(:expected_outcome) { '100234897978' }
  
    context 'when the received number has all three terms' do
      let(:input_number) { '1.00,234 897978' }
      it 'strips commas, periods and spaces from the string' do
        expect(result).to eq(expected_outcome)
      end  
    end  
  end  

  describe 'correct_format?' do
    let(:result) { described_class.correct_format?(input) }
    
    context 'when the received string is all digits' do
      let(:input) { '548789' }
      it 'returns true' do
        expect(result).to eq(true)
      end
    end

    context 'when the received string is not all digits' do
      let(:input) { '548ff' }
      it 'returns false' do
        expect(result).to eq(false)
      end
    end
  end
end