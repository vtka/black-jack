# Dealer class
class Dealer < Player
  def initialize(name='Dealer')
    super
  end

  def can_take_card?
    return false if score >= GameRules::DEALER_DECISION_BREAKPOINT || @hand.max_cards?
    true
  end
end
