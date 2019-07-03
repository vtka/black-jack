require 'forwardable'

# User parent class
class Player
  attr_accessor :name, :bank

  extend Forwardable

  def_delegators :@hand, :score, :cards
  def_delegators :@bank, :debit, :withdraw
  def_delegator :@hand, :max_cards?

  def initialize(name)
    @name = name
    @bank = Bank.new(100)
    @hand = Hand.new
  end

  def add_card(deal_card)
    @hand.add_card(deal_card)
  end

  def can_take_card?
    !@hand.max_cards?
  end
end
