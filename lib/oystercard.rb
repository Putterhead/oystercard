require_relative './balance_error'
require_relative 'station'
require_relative 'journey'

class Oystercard

  BALANCE_LIMIT = 90
  MINIMUM_CHARGE = 1
  PENALTY = 6

  attr_reader :balance, :in_journey, :entry_station, :exit_station, :trip, :journeys
  attr_writer :journeys

  def initialize
    @balance = 0
    @journeys = Array.new
    @trip = {}
  end

  def top_up(amount)
    fail(BalanceError, "Maximum balance of #{BALANCE_LIMIT} exceeded") if over_limit?(amount)
    @balance += amount
  end

  def touch_in(station)


    #journey = Journey.new(station)



    deduct(PENALTY) unless @trip == {}
    fail "Insufficient funds" if balance < MINIMUM_CHARGE
    @trip[:entry_station] = station
    @in_journey = true
  end

  def touch_out(station)
    @trip.empty? ? deduct(PENALTY) : deduct(MINIMUM_CHARGE)
    @trip[:exit_station] = station

    # journey.end(station)
    # @journeys << journey.complete
    
    @journeys << @trip
    @trip = {}
  end

  def over_limit?(amount)
    (@balance + amount) > BALANCE_LIMIT
  end

  private

  def deduct(amount)
    @balance -= amount
  end

end
