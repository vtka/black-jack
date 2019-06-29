# Dealer's cards are invisible
class DealerCard < Card
  def to_s
    '┌───────┐
     │░░░░░░░│
     │       │
     │░░░░░░░│
     │       │
     │░░░░░░░│
     └───────┘'
  end
  super
end
