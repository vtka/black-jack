# User deck and score control
class Hand
  attr_accessor :cards

  MAX_CARD_WARNING = 'У вас уже 3 карты.'

  def initialize
    @cards = []
  end

  def score
    sum = cards.map(&:value).sum
    ace_correction(sum)
  end

  private

  def ace_correction(sum)
    cards.each do |card|
      if (sum > GameRules::BLACK_JACK) && card.ace?
        sum -= GameRules::ACE_SCORE_DECISION_BREAKPOINT
      end
    end
    sum
  end
end
