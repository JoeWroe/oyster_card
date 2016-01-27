require 'oystercard.rb'

describe Oystercard do
  subject(:card) { described_class.new }
  let (:station) {double :station}

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

  describe ' #in journey?' do
    it 'is false before touch in' do
      expect(card).not_to be_in_journey
    end
  end

  describe ' #touch in' do

    it 'raises error when balance is under minimum fare cost' do
      expect{card.touch_in(station)}.to raise_error "Cannot touch-in: under minimum balance of #{Oystercard::MIN_FARE}; please top-up"
    end

    it 'changes in_journey? to true' do
      card.top_up(Oystercard::MIN_FARE)
      card.touch_in(station)
      expect(card).to be_in_journey
    end

    it 'records the entry station' do
      card.top_up(Oystercard::MIN_FARE)
      card.touch_in(:station)
      expect(card.entry_station).to eq :station
    end

  end

  describe ' #touch out' do

    before do
      card.top_up(Oystercard::MIN_FARE)
      card.touch_in(station)
    end

    it 'changes in_journey? to false' do
      card.touch_out
      expect(card).not_to be_in_journey
    end

    it 'deducts minimum fare from balance' do
      expect{card.touch_out}.to change{card.balance}.by(-Oystercard::MIN_FARE)
    end

    it "resets entry_station to nil" do
      card.touch_out
      expect(card.entry_station).to eq nil
    end
  end

end
