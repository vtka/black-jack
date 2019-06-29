# Game
class Game
  attr_reader :dealer_bank, :player_bank, :game_bank, :player, :dealer, :hand

  def initialize
    @player = Player.new(intro)
    @dealer = Dealer.new
    @player_bank = Bank.new(100)
    @dealer_bank = Bank.new(100)
    @game_bank = Bank.new
    # @hand = Hand.new
  end

  def winner
    if @hand.player_score <= GameRules::BLACK_JACK && (@hand.player_score > @hand.dealer_score || @hand.dealer_score > GameRules::BLACK_JACK)
      puts GameRules::PLAYER_WINNER_MESSAGE
      @player_bank.debit(@game_bank.amount)
      @game_bank.withdraw(@game_bank.amount)
    elsif @hand.dealer_score <= GameRules::BLACK_JACK && (@hand.player_score < @hand.dealer_score || @hand.player_score > GameRules::BLACK_JACK)
      puts GameRules::DEALER_WINNER_MESSAGE
      @dealer_bank.debit(@game_bank.amount)
      @game_bank.withdraw(@game_bank.amount)
    else
      puts GameRules::DRAW_MESSAGE
      @player_bank.debit(@game_bank.amount / 2)
      @dealer_bank.debit(@game_bank.amount / 2)
      @game_bank.withdraw(@game_bank.amount)
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

  def bet
    @player_bank.withdraw(GameRules::BET)
    @dealer_bank.withdraw(GameRules::BET)
    @game_bank.debit(GameRules::BET * 2)
  end

  def new_round
    @hand.player_deck.clear
    @hand.player_score = 0
    @hand.dealer_deck.clear
    @hand.dealer_score = 0
    @hand.new_deck = Deck.new
  end
end
