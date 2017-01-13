
class Journey

  attr_reader :trip

  def initialize
    @trip = {}
  end

  def start(station)
    @trip[:entry_station] = station
  end
end
