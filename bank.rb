class Bank
  attr_accessor :amount
  
  def initialize
    @amount = 100
  end

  def to_s
    "Balance: #{@amount}$"
  end

  def amount_zero?
    @amount == 0
  end
end