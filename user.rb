# User parent class
class User
  attr_accessor :name, :bank

  def initialize(name)
    @name = name
    @bank = Bank.new(100)
  end
end
