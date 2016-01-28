require_relative 'oystercard'

class Journey

  attr_reader :entry_station, :exit_station, :history

  def initialize
    @entry_station = nil
    @exit_station  = nil
    @history       = {}
  end

  def in_journey?
    !!entry_station
  end

  def start(entry_station)
    @history[entry_station] = nil
    @entry_station = entry_station
  end

  def end(exit_station)
    @history[@entry_station] = exit_station
    @entry_station = nil
    @exit_station = exit_station
  end

end
