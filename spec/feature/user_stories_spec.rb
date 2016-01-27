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

  #In order to keep using public transport
  #As a customer
  #I want to add money to my card

  it 'so that my card can take money, card needs to accpet top-up value' do
    card = Oystercard.new
    expect{card.top_up(10)}.not_to raise_error
  end

  it 'so that I change my balance, topping up should increase balance' do
    card=Oystercard.new
    card.top_up(10)
    expect(card.balance).to eq 10
  end

  # In order to protect my money from theft or loss
  # As a customer
  # I want a maximum limit (of £90) on my card
  it 'prevents top up when maximum balance reached' do
    card = Oystercard.new
    expect { card.top_up(Oystercard::MAX_BALANCE + 1) }.to raise_error "Cannot top up: maximum balance of #{Oystercard::MAX_BALANCE} exceeded, reduce top up amount."
  end
end
