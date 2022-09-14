class Round {
  double id;
  int state;
  int playerPoints;
  int dealerPoints;
  String playerCards;

  Round(
      {required this.id,
      required this.state,
      required this.playerPoints,
      required this.dealerPoints,
      required this.playerCards});

  Map<String, dynamic> roundToMap() {
    return {
      'id': id,
      'state': state,
      'playerPoints': playerPoints,
      'dealerPoints': dealerPoints,
      'playerCards': playerCards,
    };
  }
}
