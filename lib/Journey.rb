
class Journey

  attr_reader :trip, :complete, :entry_station, :exit_station


  def initialize(station=Station.new("none", 0))
    @entry_station = {station.name => station.zone}
    @complete = Array.new
    @complete << entry_station
  end

  def end(station=Station.new("none", 0))
    card = Oystercard.new
    @exit_station = {station.name => station.zone}
    @complete << exit_station
    @journeylog << complete
    @complete = []
  end

end
