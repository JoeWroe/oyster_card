class Oystercard

attr_reader :balance, :entry_station
MAX_BALANCE = 90
MIN_FARE = 1



  def initialize
    @balance = 0
   
   
  end



  def top_up(value)
    fail "Cannot top up: maximum balance of #{MAX_BALANCE} exceeded, reduce top up amount." if exceeds_max? (value)
  	@balance += value
  end

	def exceeds_max? (value)
		(@balance + value) > MAX_BALANCE
	end

  def deduct(value)
  	@balance -= value
  end

  def in_journey?
    !!entry_station
  end

  def touch_in (station)
  	fail "Cannot touch-in: under minimum balance of #{MIN_FARE}; please top-up" if @balance < MIN_FARE
    @journey = true
    @entry_station = station
  end

  def touch_out
    deduct MIN_FARE
    @journey = false
    @entry_station = nil
  end

end
