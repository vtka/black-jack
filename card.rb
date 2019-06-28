# Card class
class Card
  attr_accessor :rank, :suit

  SUITS = ['♤', '♡', '♢', '♧']
  RANK = %w(2 3 4 5 6 7 8 9 10 Jack Queen King Ace)

  def initialize(rank, suit)
    @rank = rank
    @suit = suit
  end

  def to_s
  "   ┌───────┐
   │#{rank[0]}      │
   │       │
   │   #{suit}   │
   │       │
   │      #{rank[0]}│
   └───────┘"
  end
end
