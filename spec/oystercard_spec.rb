require 'oystercard.rb'

describe Oystercard do
  subject(:card) { described_class.new }

  describe ' #balance' do

    it 'has a balance of 0 if never topped up' do
      expect(card.balance).to eq 0
    end

   end

   describe ' #top_up' do

    it 'increases balance by the amount passed in' do
      expect{card.top_up(10)}.to change{card.balance}.by(10)
    end

    context 'when maximum balance reached' do
      it 'raises error' do
        expect { card.top_up(Oystercard::MAX_BALANCE + 1) }.to raise_error "Cannot top up: maximum balance of #{Oystercard::MAX_BALANCE} exceeded, reduce top up amount."
      end
    end
  end

  describe ' #deduct' do
    it 'decreases balance by value passed in' do
      expect{card.deduct(1)}.to change{card.balance}.by(-1)
    end
  end

end
