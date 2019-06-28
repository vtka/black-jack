# GameRules
class GameRules
  BLACK_JACK = 21

  SCORE_BOARD = {
    '2': 2,
    '3': 3,
    '4': 4,
    '5': 5,
    '6': 6,
    '7': 7,
    '8': 8,
    '9': 9,
    'X': 10,
    'Jack': 10,
    'Queen': 10,
    'King': 10,
    'Ace': 11
  }

  ACE_SCORE_DECISION_BREAKPOINT = 10

  DEALER_DECISION_BREAKPOINT = 17

  MAX_CARDS = 3

  MAX_CARD_WARNING = 'У вас уже 3 карты.'

  BET = 10

  DEALER_PASS = 'Диллер пропускает ход'

  DEALER_HIT = 'Диллер взял карту'

  PLAYER_WINNER_MESSAGE = 'Победил игрок!'

  DEALER_WINNER_MESSAGE = 'Победил диллер!'

  DRAW_MESSAGE = 'Победила дружба!'
end
