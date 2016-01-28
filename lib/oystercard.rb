class Oystercard

attr_reader :balance, :entry_station, :exit_station, :history
MAX_BALANCE = 90
MIN_FARE = 1



  def initialize
    @balance = 0
    @history = {}


  end



  def top_up(value)
    fail "Cannot top up: maximum balance of #{MAX_BALANCE} exceeded, reduce top up amount." if exceeds_max? (value)
  	@balance += value
  end

  def deduct(value)
  	@balance -= value
  end

  def in_journey?
    !!entry_station
  end

  def touch_in(entry_station)
  	fail "Cannot touch-in: under minimum balance of #{MIN_FARE}; please top-up" if @balance < MIN_FARE
    @entry_station = entry_station
  end

  def touch_out(exit_station)
    deduct MIN_FARE
    @history[@entry_station] = exit_station
    @entry_station = nil
    @exit_station = exit_station
  end

  private

  def exceeds_max?(value)
		(@balance + value) > MAX_BALANCE
	end

end
