class Bank
  attr_reader :amount

  def initialize(amount=0)
    @amount = amount
  end

  def to_s
    "Баланс: #{@amount}$"
  end

  def amount_zero?
    @amount == 0
  end

  def debit(amount)
    @amount += amount
  end

  def withdraw(amount)
    raise NOT_ENOUGH_MONEY if amount > @amount
    @amount -= amount
  end

  def reset_bank
    @amount = 0
  end
end
