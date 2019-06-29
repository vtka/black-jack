# Game funds operator
class GameBank < Bank
  def make_bets(player, dealer, game_bank)
    player.withdraw(GameRules::BET)
    dealer.withdraw(GameRules::BET)
    game_bank.debit(GameRules::BET * 2)
  end

  def reward_winner(reciever, amount, payer)
    reciever.bank.debit(amount)
    payer.withdraw(amount)
  end

  def refund(player, dealer, game_bank)
    player.debit(game_bank.amount / 2)
    dealer.debit(game_bank.amount / 2)
    game_bank.withdraw(game_bank.amount)
  end
end
