require_relative './balance_error'
require_relative 'station'

class Oystercard

  BALANCE_LIMIT = 90
  MINIMUM_CHARGE = 1
  PENALTY = 6

  attr_reader :balance, :in_journey, :entry_station, :exit_station, :journeys

  def initialize
    @balance = 0
    @state = false
    @journeys = []
    @trip = {}
  end

  def top_up(amount)
    fail(BalanceError, "Maximum balance of #{BALANCE_LIMIT} exceeded") if over_limit?(amount)
    @balance += amount
  end

  def touch_in(station)
    fail "Insufficient funds" if balance < MINIMUM_CHARGE
    @trip[:entry_station] = station
    @in_journey = true
  end

  def touch_out(station)
    if @trip.empty?
      deduct(PENALTY)
    else
      deduct(MINIMUM_CHARGE)
      @trip[:exit_station] = station
      @journeys << @trip
    end
  end

  def over_limit?(amount)
    (@balance + amount) > BALANCE_LIMIT
  end

  private

  attr_reader :trip

  def deduct(amount)
    @balance -= amount
  end

end
