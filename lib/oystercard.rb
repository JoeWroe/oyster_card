class Oystercard

attr_reader :balance
MAX_BALANCE = 90

  def initialize
    @balance = 0
  end

  def top_up(value)
    fail "Cannot top up: maximum balance of #{MAX_BALANCE} exceeded, reduce top up amount." if (@balance + value) > MAX_BALANCE
  	@balance += value
  end

end
