# User deck and score control
class Hand
  attr_accessor :player_score, :dealer_score, :player_deck, :dealer_deck

  def initialize
    @player_deck = []
    @dealer_deck = []
    @player_score = 0
    @dealer_score = 0
  end

  def initial_hand(user, game_deck)
    2.times do
      hand_card(user, game_deck)
    end
  end

  def hand_card(user_deck, game_deck)
    if user_deck.count < GameRules::MAX_CARDS
      user_deck << game_deck.deck.delete(game_deck.deck.sample)
      score_counter
    else
      raise GameRules::MAX_CARD_WARNING
    end
  end

  def score_for(deck)
    scorecard = 0
    has_ace = false
    GameRules::SCORE_BOARD.each do |rank, score|
      deck.each do |card|
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
    @player_score = score_for(@player_deck)
    @dealer_score = score_for(@dealer_deck)
  end
end
