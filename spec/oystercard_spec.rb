require 'oystercard.rb'

describe Oystercard do
  subject(:card) { described_class.new }

  describe ' #balance' do

    it { is_expected.to respond_to(:balance) }

    it 'has a balance of 0 if never topped up' do
      expect(card.balance).to eq 0
    end
  
   end

   describe ' #top_up' do
    

    it { is_expected.to respond_to(:top_up).with(1).argument}

    it 'increases balance by the amount passed in' do
      expect{card.top_up(10)}.to change{card.balance}.by(10)
    end

  end


end
