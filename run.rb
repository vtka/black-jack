# Run the program
require_relative './interface'
class Run
  def initialize
    @interface = Interface.new
    @interface.new_game
  end
end

run = Run.new
