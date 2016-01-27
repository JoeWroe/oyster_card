describe 'user stories' do
  # In order to use public transport
  # As a customer
  # I want money on my card
  it 'so that a user can have money on a card, card needs to store money' do
    card = Oystercard.new
    expect{ card.balance }.not_to raise_error
  end

  it 'should automatically start with a balance of 0' do
    card = Oystercard.new
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


  # In order to pay for my journey
  # As a customer
  # I need my fare deducted from my card
  it 'deducts money from balance' do
    card = Oystercard.new
    old_balance = card.balance
    new_balance = card.deduct(1)
    expect(old_balance > new_balance)
  end


  # In order to get through the barriers.
  # As a customer
  # I need to touch in and out.
  it 'so that a customer can begin and end a journey, the card should touch in and out of the journey' do
    card = Oystercard.new
    card.top_up(Oystercard::MIN_FARE)
    card.touch_in
    expect(card.in_journey?).to eq true
    card.touch_out
    expect(card.in_journey?).to eq false
  end

  #In order to pay for my journey
  #As a customer
  #I need to have the minimum amount (£1) for a single journey.

  it "so that there's enough to travel, you can only touch-in with min fare value" do
    card = Oystercard.new
    expect{card.touch_in}.to raise_error "Cannot touch-in: under minimum balance of #{Oystercard::MIN_FARE}; please top-up"
  end


  # In order to pay for my journey
  # As a customer
  # When my journey is complete, I need the correct amount deducted from my card
  it 'so that a customer is charged, balance is deducted on touch out' do
    card = Oystercard.new
    card.top_up(Oystercard::MIN_FARE)
    card.touch_in
    card.touch_out
    expect(card.balance).to eq 0
  end

end
