//this class depicts the constant values used for health
class Condition {
  //playerNum > dealerNum || dealerNum > maxVal
  final smolValue = 10;
  //playerNum < dealerNum || playerNum > maxVal
  final smolValueN = -10;
  //player blackjack || double
  final medValue = 20;
  //player < 16 ||
  final medValueN = -20;
  //player 5 cards || double A
  final highValue = 30;
  //player 5 cards > maxVal
  final highValueN = -30;
  //player 5 cards blackjack
  final highestVal = 50;
  //dealer 5 cards blackjack
  final highestValN = -50;

  //both player and dealer double A
  final String doubleADraw = 'A draw by double A!';
  //player won by double A
  final String doubleAPlayer = 'You won by double A!';
  //dealer won by double A
  final String doubleADealer = 'Dealer won by double A!';

  //both player and dealer blackjack
  final String blackJackDraw = 'A draw by BlackJack!';
  //player won by blackjack
  final String blackJackPlayer = 'You won by BlackJack!';
  //dealer won by blackjack
  final String blackJackDealer = 'Dealer won by Blackjack!';

  //both player and dealer double
  final String doubleDraw = 'A draw by Double';
  //player won by double
  final String doublePlayer = 'You won by Double!';
  //dealer won by double
  final String doubleDealer = 'Dealer won by Double';

  //player less than 16 and holds
  final String lessThanHold = 'You lost as your card number is less than 16!';

  //player 5 cards burst
  final String playerFiveBurst = 'You have 5 cards but exceeded max value!';
  //dealer 5 cards burst
  final String dealerFiveBurst = 'Dealer have 5 cards but exceeded max value!';
  //both player and dealer burst
  final String burstDraw = 'A draw! Both burst!';

  //player won by 5 cards and blackjack
  final String fiveBlackJackPlayer = 'You won by BlackJack and 5 cards!';
  //dealer won by 5 cards and blackjack
  final String fiveBlackJackDealer = 'Dealer won by BlackJack and 5 cards!';

  //player won by 5 cards
  final String fivePlayer = 'You won by 5 cards!';
  //dealer won by 5 cards
  final String fiveDealer = 'Dealer won by 5 cards!';

  //both player and dealer same score
  final String bothDraw = 'A draw!';
  //player has higher score
  final String playerHigher = 'You won the dealer by having a higher score!';
  //dealer has higher score
  final String dealerHigher = 'You lost!';

  //dealer burst
  final String dealerBurst = 'Dealer has exceeded max value!';
  //player burst
  final String playerBurst = 'You have exceeded the max value!';
}
