require 'forwardable'

# User parent class
class Player
  attr_accessor :name, :bank

  extend Forwardable

  def_delegators :@hand, :score, :cards
  def_delegators :@bank, :debit, :withdraw

  def initialize(name)
    @name = name
    @bank = Bank.new(100)
    @hand = Hand.new
  end
end
