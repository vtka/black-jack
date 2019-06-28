require_relative './user'
require_relative './player'
require_relative './dealer'
require_relative './bank'
require_relative './card'
require_relative './deck'
require_relative './game'
require_relative './game_rules'
require_relative './inline_printer'

class Interface
  def initialize
    @game = Game.new # create Model
    start_game # start new game on initializing
  end

  def start_game
    puts "Добро пожаловать, #{@game.player.name}!"
  end

  def new_game
    loop do
      system('clear')
      puts 'Новая игра!'
      @game.bet
      puts "Общая ставка: #{@game.game_bank}"
      first_round
      second_round
      third_round
      break if @game.player_bank.amount_zero? || @game.dealer_bank.amount_zero?

    end
  end

  def first_round
    @game.shuffle_deck
    @game.initial_hand(@game.player_deck, @game.dealer_deck)
    show_assets
  end

  def second_round
    puts '(1) Пропустить ход (2) Взять карту (3) Открыть карты'
    choice = gets.to_i
    pass if choice == 1 || choice == 3
    hit(@game.player_deck) if choice == 2
    @game.dealer_turn
    show_assets
  end

  def third_round
    show_assets
    puts 'Calculating points....'
    p @game.game_bank
    sleep(2.0)
    @game.winner
    sleep(2.0)
    @game.new_round
  end

  def pass
    @game.dealer_turn
  end

  def hit(deck)
    @game.hand_card(deck)
  end

  def show_assets
    system('clear')
    puts "#{@game.player.name}:"
    puts @game.player_bank
    InlinePrinter.new.print(@game.player_deck)
    p @game.player_score
    puts '--------------------'
    puts @game.dealer_bank
    puts 'Dealer:'
    InlinePrinter.new.print(@game.dealer_deck)
    p @game.dealer_score
  end
end

interface = Interface.new
interface.new_game
