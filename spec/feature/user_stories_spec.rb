describe 'user stories' do
  # In order to use public transport
  # As a customer
  # I want money on my card
  it 'so that a user can have money on a card, card needs to store money' do
    card = Oystercard.new
    expect{ card.balance }.not_to raise_error
  end

  it 'should automatically start with a balance of 0' do
    card =Oystercard.new
    expect(card.balance).to eq 0
  end
end
