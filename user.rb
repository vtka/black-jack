# User parent class
class User
  attr_accessor :name, :score

  def initialize(name)
    @hand = Hand.new
    @name = name
    @score = 0
  end
end
