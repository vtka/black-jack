class Deck
  attr_accessor :deck

  def initialize
    @deck = []
    fill_deck
  end

  def fill_deck
    Card::SUITS.each do |suit|
      Card::RANK.each do |rank|
        @deck << Card.new(rank, suit)
      end
    end
    @deck.shuffle!
  end
end
