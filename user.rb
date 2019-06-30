# User parent class
class User
  attr_accessor :name, :bank

  def initialize(name)
    @name = name
    @bank = Bank.new(100)
    @hand = Hand.new
  end

  def score
    @hand.user_score
  end

  def clear_score
    @hand.user_score = 0
  end

  def deck
    @hand.cards
  end

  def take_starter_cards(game_deck)
    @hand.initial_hand(game_deck)
  end

  def take_card(game_deck)
    @hand.hand_card(game_deck)
  end
end
