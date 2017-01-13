
class Journey
  MINIMUM_CHARGE = 1

  attr_reader :complete, :entry_station, :exit_station


  def initialize(station=Station.new("none", 0))
    @entry_station = {station.name => station.zone}
    @complete = Array.new
    @complete << @entry_station
  end

  def end(station=Station.new("none", 0))
    @exit_station = {station.name => station.zone}
    @complete << @exit_station
  end

  def fare
    MINIMUM_CHARGE
  end

end
