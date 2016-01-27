require 'oystercard.rb'

describe Oystercard do
  subject(:card) { described_class.new }

  describe ' #balance' do

    it { is_expected.to respond_to(:balance) }

    it 'has a balance of 0 if never topped up' do
      expect(card.balance).to eq 0
    end

  end



end
