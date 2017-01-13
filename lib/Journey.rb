
class Journey
  MINIMUM_CHARGE = 1
  PENALTY = 6

  attr_reader :complete, :entry_station, :exit_station, :in_journey


  def initialize(station=Station.new("none", 0))
    @entry_station = {station.name => station.zone}
    @complete = Array.new
    @complete << @entry_station
  end

  def end(station=Station.new("none", 0))
    @exit_station = {station.name => station.zone}
    @complete << @exit_station
  end

  def in_journey
    @complete.size > 0 ? true : false
  end

  def fare
    @complete.size > 1 ? MINIMUM_CHARGE : PENALTY
  end

end
