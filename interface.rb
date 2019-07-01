#Interface class
class Interface
  def initialize
    puts GameRules::WELCOME_MESSAGE
  end

  def welcome_message(to_whom)
    puts "Добро пожаловать, #{to_whom}!"
  end

  def new_game_message
    puts 'Новая игра!'
  end

  def show_total_bank(source)
    puts "Общая ставка: #{source}"
  end

  def show_player_options
    puts '(1) Пропустить ход (2) Взять карту (3) Открыть карты'
  end

  def show_last_options
    puts '(2) Взять карту (3) Открыть карты'
  end

  def card_reveal_message
    puts 'Диллер открывает карты....'
  end

  def scoring_message
    puts 'Идет подсчет очков....'
  end

  def show_winner(winner)
    puts "Победил #{winner.name}!"
  end

  def show_draw
    puts GameRules::DRAW_MESSAGE
  end

  def dealer_pass_message
    puts GameRules::DEALER_PASS
  end

  def dealer_hit_message
    puts GameRules::DEALER_HIT
  end

  def show_assets(last_round, player, dealer)
    system('clear')
    puts "#{player.name}:"
    puts "#{player.bank}"
    InlinePrinter.new.print(player.cards)
    puts "Ваши очки: #{player.score}"
    puts '--------------------'
    puts "#{dealer.bank}"
    puts 'Диллер:'
    if last_round == true
      InlinePrinter.new.print(dealer.cards)
      puts puts "Очки диллера: #{dealer.score}"
    else
      InlinePrinter.new.print_masked(dealer.cards)
    end
  end
end
