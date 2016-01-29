require_relative 'oystercard'

class Journey

  attr_reader :entry_station, :exit_station, :history

  def in_journey?
    !!entry_station
  end

  def start(entry_station)
    @entry_station                   = entry_station
  end

  def end(exit_station)
    @exit_station                    = exit_station
  end

end
