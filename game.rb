require_relative './player'
require_relative './dealer'
require_relative './bank'
require_relative './game_bank'
require_relative './card'
require_relative './deck'
require_relative './interface'
require_relative './game_rules'
require_relative './inline_printer'
require_relative './hand'

# Game
class Game
  attr_accessor :game_bank, :new_deck
  attr_reader :player, :dealer, :hand

  def initialize
    @interface = Interface.new
    @player = Player.new(intro)
    @dealer = Dealer.new
    @new_deck = Deck.new
    @game_bank = GameBank.new
    @winner = nil
  end

  def start_game
    @interface.welcome_message(@player.name)
  end

  def new_game
    start_game
    loop do
      system('clear')
      @interface.new_game_message
      @game_bank.make_bets(@player.bank, @dealer.bank, @game_bank)
      @interface.show_total_bank(@game_bank)
      first_round
      @interface.show_assets(false, @player, @dealer)
      @interface.show_player_options
      second_round
      @interface.show_assets(false, @player, @dealer)
      @interface.card_reveal_message
      sleep(2.0)
      @interface.show_assets(true, @player, @dealer)
      @interface.scoring_message
      sleep(2.0)
      winner
      sleep(2.0)
      new_round
      break if @player.bank.amount_zero? || @dealer.bank.amount_zero?
    end
  end

  def winner
    if @player.score <= GameRules::BLACK_JACK && (@player.score > @dealer.score || @dealer.score > GameRules::BLACK_JACK)
      winner = @player
      @interface.show_winner(GameRules::PLAYER_WINNER_MESSAGE)
      @game_bank.reward_winner(@player, @game_bank.amount, @game_bank)
    elsif @dealer.score <= GameRules::BLACK_JACK && (@player.score < @dealer.score || @player.score > GameRules::BLACK_JACK)
      winner = @dealer
      @interface.show_winner(GameRules::DEALER_WINNER_MESSAGE)
      @game_bank.reward_winner(@dealer, @game_bank.amount, @game_bank)
    else
      @winner = nil
      @interface.show_winner(GameRules::DRAW_MESSAGE)
      @game_bank.refund(@player.bank, @dealer.bank, @game_bank)
    end
  end

  def intro
    gets.chomp.to_s
  end

  def first_round
    initial_hand(@player)
    initial_hand(@dealer)
  end

  def second_round
    choice = gets.to_i
    pass if choice == 1 || choice == 3
    hit(@player) if choice == 2
    dealer_turn
  end

  def new_round
    @player.deck.clear
    @dealer.deck.clear
    @new_deck = Deck.new
  end

  def add_card(cards)
    if cards.count < GameRules::MAX_CARDS
      cards << @new_deck.deck.delete(@new_deck.deck.sample)
    else
      raise Hand::MAX_CARD_WARNING
    end
  end

  def initial_hand(player)
    2.times do
      hit(player)
    end
  end

  def hit(player)
    add_card(player.deck)
  end

  def pass
    dealer_turn
  end

  def dealer_turn
    if @dealer.score >= GameRules::DEALER_DECISION_BREAKPOINT || @dealer.deck.count >= GameRules::MAX_CARDS
      puts GameRules::DEALER_PASS
    else
      hit(@dealer)
      puts GameRules::DEALER_HIT
    end
  end
end
