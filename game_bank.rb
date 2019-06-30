# Game funds operator
class GameBank < Bank
  def make_bets(*players)
    players.each do |player|
      player.withdraw(GameRules::BET)
      debit(GameRules::BET)
    end
  end

  def reward_winner(winner)
    winner.debit(amount)
    reset_bank
  end

  def refund(*players)
    refund_amount = amount / players.size.to_f
    players.each do |player|
      player.debit(refund_amount)
      withdraw(refund_amount)
    end
  end
end
