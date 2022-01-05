class OysterCard 
  MAXIMUM_BALANCE = 90
  MINIMUM_BALANCE = 1
  MINIMUM_CHARGE = 3

  attr_reader :balance, :in_use

  def initialize
    @balance = 0
    @in_use = false
  end

  def deduct (amount)
    @balance -= amount
  end

  def top_up(amount)
    fail "Maximum balance of #{MAXIMUM_BALANCE} reached" if balance + amount > MAXIMUM_BALANCE
    @balance += amount
  end

  def in_journey?
    @in_use 
  end

  def touch_in
    fail "Insufficient funds" if @balance <= MINIMUM_BALANCE
    @in_use = true
  end

  def touch_out 
    deduct(MINIMUM_CHARGE)
    @in_use = false
  end

  private

end