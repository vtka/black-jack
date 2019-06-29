# Game
class Game
  attr_accessor :game_bank
  attr_reader :player, :dealer, :hand

  def initialize
    @player = Player.new(intro)
    @dealer = Dealer.new
    @game_bank = GameBank.new
    @hand = Hand.new
  end

  def winner
    if @hand.player_score <= GameRules::BLACK_JACK && (@hand.player_score > @hand.dealer_score || @hand.dealer_score > GameRules::BLACK_JACK)
      puts GameRules::PLAYER_WINNER_MESSAGE
      @game_bank.reward_winner(@player, @game_bank.amount, @game_bank)
    elsif @hand.dealer_score <= GameRules::BLACK_JACK && (@hand.player_score < @hand.dealer_score || @hand.player_score > GameRules::BLACK_JACK)
      puts GameRules::DEALER_WINNER_MESSAGE
      @game_bank.reward_winner(@dealer, @game_bank.amount, @game_bank)
    else
      puts GameRules::DRAW_MESSAGE
      @game_bank.refund(@player.bank, @dealer.bank, @game_bank)
    end
  end

  def intro
    puts 'Добро пожаловать. Укажите ваше имя:'
    gets.chomp.to_s
  end

  def dealer_turn
    if @hand.dealer_score >= GameRules::DEALER_DECISION_BREAKPOINT || @hand.dealer_deck.count >= GameRules::MAX_CARDS
      puts GameRules::DEALER_PASS
    else
      @hand.hand_card(@hand.dealer_deck)
      puts GameRules::DEALER_HIT
    end
  end

  # def bet
  #   @player.bank.withdraw(GameRules::BET)
  #   @dealer.bank.withdraw(GameRules::BET)
  #   @game_bank.debit(GameRules::BET * 2)
  # end

  def new_round
    @hand.player_deck.clear
    @hand.player_score = 0
    @hand.dealer_deck.clear
    @hand.dealer_score = 0
    @hand.new_deck = Deck.new
  end
end
