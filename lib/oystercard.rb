require_relative './balance_error'

class Oystercard

  BALANCE_LIMIT = 90
  MINIMUM_CHARGE = 1

  attr_reader :balance, :state

  def initialize
    @balance = 0
    @state = false
  end

  def top_up(amount)
    fail(BalanceError, "Maximum balance of #{BALANCE_LIMIT} exceeded") if over_limit?(amount)
    @balance += amount
  end

  def deduct(amount)
    @balance -= amount
  end

  def in_journey?
    @state
  end

  def touch_in
    fail "Insufficient funds" if balance < MINIMUM_CHARGE
    @state = true
  end

  def touch_out
    @state = false
  end

  def over_limit?(amount)
    (@balance + amount) > BALANCE_LIMIT
  end

end
