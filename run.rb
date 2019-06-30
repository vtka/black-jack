# Run the program
require_relative './game'
class Run
  def initialize
    @game = Game.new
    @game.new_game
  end
end

run = Run.new
