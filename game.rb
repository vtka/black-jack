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
      starter_announcer
      first_round
      round_announcer
      @interface.show_player_options
      play_round
      result_announcer
      # sleep(2.0)
      end_round
      # sleep(2.0)
      new_round
      break if @player.bank.amount_zero? || @dealer.bank.amount_zero?
    end
  end

  def intro
    gets.chomp.to_s
  end

  private

  def define_winner
    if player_won?
      @winner = @player
    elsif dealer_won?
      @winner = @dealer
    else
      @winner = nil
    end
  end

  def player_won?
    @player.score <= GameRules::BLACK_JACK && (@player.score > @dealer.score || @dealer.score > GameRules::BLACK_JACK)
  end

  def dealer_won?
    @dealer.score <= GameRules::BLACK_JACK && (@player.score < @dealer.score || @player.score > GameRules::BLACK_JACK)
  end

  def end_round
    winner = define_winner
    if winner
      @interface.show_winner(winner)
      @game_bank.reward_winner(winner)
    else
      @interface.show_draw
      @game_bank.refund(@player, @dealer)
    end
  end

  def play_round
    loop do
      choice = gets.to_i
      player_turn(choice)
      round_announcer
      @interface.show_last_options
      break if choice == 3 || @player.max_cards? || (@dealer.max_cards? && @player.max_cards?)
    end
  end

  def first_round
    initial_hand(@player)
    initial_hand(@dealer)
  end

  def player_turn(choice)
    pass if choice == 1 || choice == 3
    hit(@player) if choice == 2
  end

  def starter_announcer
    @interface.new_game_message
    @game_bank.make_bets(@player, @dealer)
    @interface.show_total_bank(@game_bank)
  end

  def round_announcer
    @interface.show_assets(false, @player, @dealer)
  end

  def result_announcer
    # sleep(2.0)
    @interface.card_reveal_message
    @interface.show_assets(true, @player, @dealer)
    @interface.scoring_message
  end

  def new_round
    @player.cards.clear
    @dealer.cards.clear
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
    add_card(player.cards)
  end

  def pass
    dealer_turn
  end

  def dealer_turn
    if @dealer.score >= GameRules::DEALER_DECISION_BREAKPOINT || @dealer.cards.count >= GameRules::MAX_CARDS
      @interface.dealer_pass_message
    else
      hit(@dealer)
      @interface.dealer_hit_message
    end
  end
end
