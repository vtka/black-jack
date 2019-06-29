# Game
class Game
  attr_accessor :game_bank, :new_deck
  attr_reader :player, :dealer, :hand

  def initialize
    @player = Player.new(intro)
    @dealer = Dealer.new
    @new_deck = Deck.new
    @game_bank = GameBank.new
  end

  def winner
    if @player.score <= GameRules::BLACK_JACK && (@player.score > @dealer.score || @dealer.score > GameRules::BLACK_JACK)
      puts GameRules::PLAYER_WINNER_MESSAGE
      @game_bank.reward_winner(@player, @game_bank.amount, @game_bank)
    elsif @dealer.score <= GameRules::BLACK_JACK && (@player.score < @dealer.score || @player.score > GameRules::BLACK_JACK)
      puts GameRules::DEALER_WINNER_MESSAGE
      @game_bank.reward_winner(@dealer, @game_bank.amount, @game_bank)
    else
      puts GameRules::DRAW_MESSAGE
      @game_bank.refund(@player.bank, @dealer.bank, @game_bank)
    end
  end

  def intro
    gets.chomp.to_s
  end

  def first_round
    @player.take_starter_cards(@new_deck)
    @dealer.take_starter_cards(@new_deck)
  end

  def second_round
    choice = gets.to_i
    pass if choice == 1 || choice == 3
    hit(@new_deck) if choice == 2
    dealer_turn # user deck everywhere
  end

  def new_round
    @player.deck.clear
    @player.clear_score
    @dealer.deck.clear
    @dealer.clear_score
    @new_deck = Deck.new
  end

  def hit(game_deck)
    @player.take_card(game_deck)
  end

  def pass
    dealer_turn
  end

  def dealer_turn
    if @dealer.score >= GameRules::DEALER_DECISION_BREAKPOINT || @dealer.deck.count >= GameRules::MAX_CARDS
      puts GameRules::DEALER_PASS
    else
      @dealer.take_card(@new_deck)
      puts GameRules::DEALER_HIT
    end
  end
end
