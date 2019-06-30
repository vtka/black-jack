# User parent class
class Player
  attr_accessor :name, :bank

  def initialize(name)
    @name = name
    @bank = Bank.new(100)
    @hand = Hand.new
  end

  def score
    @hand.score_counter
  end

  def deck
    @hand.cards
  end
end
