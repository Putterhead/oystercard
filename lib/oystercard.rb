require_relative './balance_error'
require_relative 'station'
require_relative 'journey'

class Oystercard

  BALANCE_LIMIT = 90
  MINIMUM_CHARGE = 1
  PENALTY = 6

  attr_reader :balance, :journey, :journeylog
  attr_writer :journeylog

  def initialize
    @balance = 0
    @journeylog = Array.new
    @journey = nil
  end

  def top_up(amount)
    fail(BalanceError, "Maximum balance of #{BALANCE_LIMIT} exceeded") if over_limit?(amount)
    @balance += amount
  end

  def touch_in(station)
    deduct(PENALTY) if @journey != nil
    fail "Insufficient funds" if balance < MINIMUM_CHARGE
    @journey = Journey.new(station)
  end

  def touch_out(station)
    fail "No journey initiated" if @journey == nil
    @journey.end(station)
    @journeylog << @journey.complete
    deduct(@journey.fare)
    @journey = nil
  end

  def over_limit?(amount)
    (@balance + amount) > BALANCE_LIMIT
  end

  private

  def deduct(amount)
    @balance -= amount
  end

end
