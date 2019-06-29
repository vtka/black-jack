require_relative './user'
require_relative './player'
require_relative './dealer'
require_relative './bank'
require_relative './game_bank'
require_relative './card'
require_relative './deck'
require_relative './game'
require_relative './game_rules'
require_relative './inline_printer'
require_relative './hand'

class Interface
  def initialize
    puts GameRules::WELCOME_MESSAGE
    @game = Game.new
    start_game
  end

  def start_game
    puts "Добро пожаловать, #{@game.player.name}!"
  end

  def new_game
    loop do
      system('clear')
      puts 'Новая игра!'
      @game.game_bank.make_bets(@game.player.bank, @game.dealer.bank, @game.game_bank)
      puts "Общая ставка: #{@game.game_bank}"
      @game.first_round
      show_assets(false)
      puts '(1) Пропустить ход (2) Взять карту (3) Открыть карты'
      @game.second_round
      show_assets(false)
      puts 'Диллер открывает карты....'
      sleep(2.0)
      show_assets(true)
      puts 'Идет подсчет очков....'
      sleep(2.0)
      @game.winner
      sleep(2.0)
      @game.new_round
      break if @game.player.bank.amount_zero? || @game.dealer.bank.amount_zero?
    end
  end

  def show_assets(last_round)
    system('clear')
    puts "#{@game.player.name}:"
    puts @game.player.bank
    InlinePrinter.new.print(@game.hand.player_deck)
    puts "Ваши очки: #{@game.hand.player_score}"
    puts '--------------------'
    puts @game.dealer.bank
    puts 'Диллер:'
    if last_round == true
      InlinePrinter.new.print(@game.hand.dealer_deck)
      puts puts "Очки диллера: #{@game.hand.dealer_score}"
    else
      InlinePrinter.new.print_masked(@game.hand.dealer_deck)
    end
  end
end
