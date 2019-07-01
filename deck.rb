class Deck
  attr_accessor :deck

  def initialize
    @deck = []
    fill_deck
  end

  def fill_deck
    Card::SUITS.each do |suit|
      Card::SCORE_BOARD.each do |rank, value|
        @deck << Card.new(rank, suit, value)
      end
    end
    @deck.shuffle!
  end
end
