# Card class
class Card
  attr_accessor :rank, :suit

  SUITS = ['♤', '♡', '♢', '♧']
  RANK = %w(2 3 4 5 6 7 8 9 X J Q K A) # X - потому что 10-ка портит весь графон

  def initialize(rank, suit)
    @rank = rank
    @suit = suit
  end

  def to_s(hidden: false)
    unless hidden
  "   ┌───────┐
   │#{rank}      │
   │       │
   │   #{suit}   │
   │       │
   │      #{rank}│
   └───────┘"
     else
  '   ┌───────┐
   │░░░░░░░│
   │       │
   │░░░░░░░│
   │       │
   │░░░░░░░│
   └───────┘'
    end
  end
end
