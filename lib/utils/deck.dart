class Deck {
  late int _numberOfDecks;
  late int _openedCards;
  late int _closedCards;
  late List<String> _deck = [];
  late int _deckCount;

  Deck(int n) {
    _numberOfDecks = n;
    _deck = initDeck();
    _openedCards = 0;
    _closedCards = _deck.length;
    _deckCount = 0;
  }

  ///get List deck
  List get getDeck => _deck;
  //set List deck
  set setDeck(List<String> l) => _deck = l;

  ///get count opened cards
  int get getOpenedCards => _openedCards;
  //set count opened cards
  set setOpenedCards(int i) => _openedCards = i;

  ///get count closed cards
  int get getClosedCards => _closedCards;
  //set count closed cards
  set setClosedCards(int i) => _closedCards = i;

  ///get deckCount
  int get getDeckCount => _deckCount;

  ///get numberOfDecks
  int get getNumberOfDecks => _numberOfDecks;

  /// OpenCard - open a new card in the sequence of the deck
  String openCard() {
    if (_closedCards != 0) {
      String result = getDeck[(getNumberOfDecks * 52) - getClosedCards];
      setClosedCards = getClosedCards - 1;
      setOpenedCards = getOpenedCards + 1;
      countCard(result);
      return result;
    } else {
      print("Misturando novo conjunto de cartas!");
      getDeck.shuffle();
      setOpenedCards = 0;
      setClosedCards = getDeck.length;
      return getDeck[(getNumberOfDecks * 52) - getClosedCards];
    }
  }

  /// CountCard - check the counting of each card (+1, 0, -1)
  ///
  /// [s] - card to be analised
  void countCard(String s) {
    switch (s[0]) {
      case "A":
        _deckCount -= 1;
        break;
      case "2":
        _deckCount += 1;
        break;
      case "3":
        _deckCount += 1;
        break;
      case "4":
        _deckCount += 1;
        break;
      case "5":
        _deckCount += 1;
        break;
      case "6":
        _deckCount += 1;
        break;
      case "1":
        _deckCount -= 1;
        break;
      case "J":
        _deckCount -= 1;
        break;
      case "Q":
        _deckCount -= 1;
        break;
      case "K":
        _deckCount -= 1;
        break;
      default:
        break;
    }
  }

  ///InitDeck - init a new deck with 52 cards and how many the player wants, already shuffled
  List<String> initDeck() {
    List<String> auxDeck = [];

    for (int i = 0; i < 4; i++) {
      late String suit;
      switch (i) {
        case 0:
          suit = "C"; //Clubs
          break;
        case 1:
          suit = "D"; //Diamonds
          break;
        case 2:
          suit = "H"; //Hearts
          break;
        case 3:
          suit = "S"; //Sword
          break;
      }
      auxDeck += [
        'A$suit',
        '2$suit',
        '3$suit',
        '4$suit',
        '5$suit',
        '6$suit',
        '7$suit',
        '8$suit',
        '9$suit',
        '10$suit',
        'J$suit',
        'Q$suit',
        'K$suit'
      ];
    }
    List<String> finalDeck = [];

    for (int k = 0; k < _numberOfDecks; k++) {
      finalDeck += auxDeck;
    }
    finalDeck.shuffle();
    return finalDeck;
  }
}
