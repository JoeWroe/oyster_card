require 'journey'

describe Journey do
  subject(:journey) { described_class.new }
  let(:card) { Oystercard.new }
  let (:entry_station) { double :entry_station }
  let (:exit_station)  { double :exit_station }

  describe ' #maintenance' do

    context ' when starting a journey' do
      it 'is not in journey before touch in' do
        expect(journey).not_to be_in_journey
      end
    end
  end

  describe ' #usage' do
    context 'when starting a journey' do
      it 'is in journey when touched in' do
        journey.start(entry_station)
        expect(journey).to be_in_journey
      end

      it 'records the entry station' do
        card.top_up(Oystercard::MIN_FARE)
        card.touch_in(entry_station)
        expect(card.journey.entry_station).to eq entry_station
      end
    end

    context 'when ending a journey' do
      it 'is not in journey after touch out' do
        card.top_up(Oystercard::MIN_FARE)
        card.touch_in(entry_station)
        card.touch_out(exit_station)
        expect(card.journey).to be nil
      end

      # it 'records the exit station' do
      #   card.touch_out(exit_station)
      #   expect(card.exit_station).to eq exit_station
      # end

    end
  end



  #       it 'records the exit station' do
  #         card.touch_out(exit_station)
  #         expect(card.exit_station).to eq exit_station
  #       end



  #       context 'no touch in or touch out occurs' do
  #         it 'records a journey when there is no touch out' do
  #           card = Oystercard.new
  #           card.top_up(20)
  #           card.touch_in(:entry_station)
  #           card.touch_in(:entry_station)
  #           expect(card.history).to include(:entry_station => nil)
  #         end
end
