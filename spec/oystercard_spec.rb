require 'oystercard.rb'

describe Oystercard do
  let (:card)          { described_class.new(journey_klass) }
  let (:entry_station) { double :entry_station }
  let (:exit_station)  { double :exit_station }
  let (:journey)       { double :journey}
  let(:journey_klass)  { double('journey_klass')}

  describe ' #maintainence' do

    context ' when balance is checked' do
      it 'has a balance of 0 if never topped up' do
        expect(card.balance).to eq 0
      end
    end

    context ' when topping up' do
      it 'increases balance by the amount passed in' do
        expect{card.top_up(10)}.to change{card.balance}.by(10)
      end

      it 'raises error when maximum exceeded' do
        expect { card.top_up(Oystercard::MAX_BALANCE + 1) }.to raise_error "Cannot top up: maximum balance of #{Oystercard::MAX_BALANCE} exceeded, reduce top up amount."
      end
    end

    context ' when deducting credit' do
      it 'decreases balance by value passed in' do
        expect{card.deduct(1)}.to change{card.balance}.by(-1)
      end
    end


    context ' when checking history' do

      before do
        allow(journey_klass).to receive(:new){journey}
        allow(journey).to receive(:start){:entry_station}
        allow(journey).to receive(:end){:exit_station}
      end

      it 'returns the entry and exit station together' do
        card.top_up(20)
        card.touch_in(:entry_station)
        card.touch_out(:exit_station)
        expect(card.history).to include(journey)
      end
    end
  end


  describe ' #usage' do

    context ' when starting a journey' do
#       it 'is not in journey before touch in' do
#         expect(card).not_to be_in_journey
#       end

      it 'touching in raises error when balance is under minimum fare cost' do
        expect{card.touch_in(entry_station)}.to raise_error "Cannot touch-in: under minimum balance of #{Oystercard::MIN_FARE}; please top-up"
      end

#       it 'is in journey when touched in' do
#         card.top_up(Oystercard::MIN_FARE)
#         card.touch_in(entry_station)
#         expect(card).to be_in_journey
#       end
#
#       it 'records the entry station' do
#         card.top_up(Oystercard::MIN_FARE)
#         card.touch_in(entry_station)
#         expect(card.entry_station).to eq entry_station
#       end
    end

    context ' when ending a journey' do
      before do
        card.top_up(Oystercard::MIN_FARE)
        card.touch_in(entry_station)
      end

      it 'touching out take a station as an argument' do
        expect(card).to respond_to(:touch_out).with(1).argument
      end

#       it 'is not in journey after touch out' do
#         card.touch_out(exit_station)
#         expect(card).not_to be_in_journey
#       end
#
      it 'deducts minimum fare from balance' do
        expect{card.touch_out(exit_station)}.to change{card.balance}.by(-Oystercard::MIN_FARE)
      end

#       it "resets entry_station to nil" do
#         card.touch_out(exit_station)
#         expect(card.entry_station).to eq nil
#       end
#
#       it 'records the exit station' do
#         card.touch_out(exit_station)
#         expect(card.exit_station).to eq exit_station
#       end
    end


    describe ' #edge cases' do

      context 'no touch in or touch out occurs' do
#         it 'records a journey when there is no touch out' do
#           card = Oystercard.new
#           card.top_up(20)
#           card.touch_in(:entry_station)
#           card.touch_in(:entry_station)
#           expect(card.history).to include(:entry_station => nil)
#         end
      end
    end
  end
end
