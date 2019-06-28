# Game
class Game
  attr_reader :player_deck, :dealer_deck, :player_score, :dealer_score, :dealer_bank, :player_bank, :game_bank, :player, :dealer, :new_deck

  def initialize
    @player = Player.new(intro)
    @dealer = Dealer.new
    @player_bank = Bank.new
    @dealer_bank = Bank.new
    @new_deck = Deck.new
    @game_bank = 0
    @player_deck = []
    @dealer_deck = []
    @player_score = 0
    @dealer_score = 0
  end

  def winner
    if @player_score <= GameRules::BLACK_JACK && (@player_score > @dealer_score || @dealer_score > GameRules::BLACK_JACK)
      puts GameRules::PLAYER_WINNER_MESSAGE
      @player_bank.amount += @game_bank
      @game_bank = 0
    elsif @dealer_score <= GameRules::BLACK_JACK && (@player_score < @dealer_score || @player_score > GameRules::BLACK_JACK)
      puts GameRules::DEALER_WINNER_MESSAGE
      @dealer_bank.amount += @game_bank
      @game_bank = 0
    else
      puts GameRules::DRAW_MESSAGE
      @player_bank.amount += (@game_bank / 2)
      @dealer_bank.amount += (@game_bank / 2)
      @game_bank = 0
    end
  end

  def intro
    puts 'Добро пожаловать. Укажите ваше имя:'
    gets.chomp.to_s
  end

  def shuffle_deck
    @new_deck.deck.shuffle
  end

  def hand_card(deck)
    if deck.count < GameRules::MAX_CARDS
      deck << @new_deck.deck.delete(@new_deck.deck.sample)
      score_counter
    else
      raise GameRules::MAX_CARD_WARNING
    end
  end

  def dealer_turn
    if @dealer_score >= GameRules::DEALER_DECISION_BREAKPOINT || @dealer_deck.count >= GameRules::MAX_CARDS
      puts GameRules::DEALER_PASS
    else
      hand_card(@dealer_deck)
      puts GameRules::DEALER_HIT
    end
  end

  def initial_hand(player, dealer) # try add yield to reduce lines
    2.times do
      hand_card(player)
    end
    2.times do
      hand_card(dealer)
    end
  end

  def score_counter
    @player_score = score_for(@player_deck)
    @dealer_score = score_for(@dealer_deck)
  end

  def score_for(deck)
    scorecard = 0
    GameRules::SCORE_BOARD.each do |rank, score|
      deck.sort_by { |elem| Card::RANK.index elem }
      deck.each do |card|
        if card.rank == rank.to_s
          if scorecard >= GameRules::ACE_SCORE_DECISION_BREAKPOINT
            GameRules::SCORE_BOARD[:Ace] = 1
            scorecard += score
          else
            scorecard += score
          end
        end
      end
    end
    scorecard
  end

  def bet
    @player_bank.amount -= GameRules::BET
    @dealer_bank.amount -= GameRules::BET
    @game_bank += GameRules::BET * 2
  end

  def new_round
    @player_deck.clear
    @player_score = 0
    @dealer_deck.clear
    @dealer_score = 0
    @new_deck = Deck.new
  end

  def clear_round
    @player.cards.clear
    @player.points = 0
    @dealer.cards.clear
    @dealer.points = 0
    @deck.generate
  end
end
