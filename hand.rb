# User deck and score control
class Hand
  attr_accessor :cards

  MAX_CARD_WARNING = 'У вас уже 3 карты.'

  def initialize
    @cards = []
  end

  def score_for(cards)
    scorecard = 0
    has_ace = false
    GameRules::SCORE_BOARD.each do |rank, score|
      cards.each do |card|
        scorecard += score if card.rank == rank.to_s
        has_ace = true if card.rank == 'A'
      end
    end
    if scorecard > GameRules::BLACK_JACK && has_ace
      scorecard -= GameRules::ACE_SCORE_DECISION_BREAKPOINT
    else
      scorecard
    end
  end

  def score_counter
    score_for(@cards)
  end
end
