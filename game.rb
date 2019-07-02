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

  PLAYER_ACTIONS = {
    pass: 1,
    hit: 2,
    reveal: 3
  }

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
      sleep(2.0)
      end_round
      sleep(2.0)
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
    return false if @player.score > GameRules::BLACK_JACK
    @player.score > @dealer.score || @dealer.score > GameRules::BLACK_JACK
  end

  def dealer_won?
    return false if @dealer.score > GameRules::BLACK_JACK
    @dealer.score > @player.score || @player.score > GameRules::BLACK_JACK
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
      begin
        choice = gets.to_i
        player_turn(choice)
        round_announcer
        @interface.show_last_options
        break if choice == PLAYER_ACTIONS[:reveal] || @player.max_cards? || (@dealer.max_cards? && @player.max_cards?)
      rescue => e
        puts e.message
        retry
      end
    end
  end

  def first_round
    initial_hand(@player)
    initial_hand(@dealer)
  end

  def player_turn(choice)
    if choice == PLAYER_ACTIONS[:pass] || choice == PLAYER_ACTIONS[:reveal]
      pass
    elsif choice == PLAYER_ACTIONS[:hit]
      @player.add_card(@new_deck.deal_card)
      dealer_turn
    end
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
    sleep(2.0)
    @interface.card_reveal_message
    @interface.show_assets(true, @player, @dealer)
    @interface.scoring_message
  end

  def new_round
    @player.cards.clear
    @dealer.cards.clear
    @new_deck = Deck.new
  end

  def initial_hand(player)
    2.times do
      player.add_card(@new_deck.deal_card)
    end
  end

  def pass
    dealer_turn
  end

  def dealer_turn
    unless @dealer.can_take_card?
      @interface.dealer_pass_message
    else
      @dealer.add_card(@new_deck.deal_card)
      @interface.dealer_hit_message
    end
  end
end
