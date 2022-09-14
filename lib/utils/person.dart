import 'deck.dart';

class Person {
  late String _name;
  late List<String> _cards;
  late int _cardsValue;
  late int _victorys;
  late int _loses;
  late bool _stand;
  late bool _explode;
  late bool _dealer;
  late bool _blackjack;

  ///Constructor [Person]
  ///
  ///[n] - name of the person
  ///[d] - if is or isn`t a dealer
  Person(String n, bool d) {
    _name = n;
    _cards = [];
    _stand = false;
    _explode = false;
    _victorys = 0;
    _loses = 0;
    _blackjack = false;
    if (d) {
      _dealer = true;
    } else {
      _dealer = false;
    }
  }

  ///get the name of person
  String get getName => _name;
  //set name
  set setName(String n) => _name = n;

  ///get cards in hand
  List get getCards => _cards;
  //set cards
  set setCards(List<String> l) => _cards = l;

  ///get cardsValue in hand
  int get getCardsValue => _cardsValue;
  //set cardsVAlue
  set setCardsValue(int i) => _cardsValue = i;

  ///get if the person stand
  bool get getStand => _stand;
  //set stand
  set setStand(bool b) => _stand = b;

  ///get if the hand explode
  bool get getExplode => _explode;
  //set explode
  set setExplode(bool b) => _explode = b;

  ///get how many victorys have the person
  int get getVictorys => _victorys;
  //set victorys
  set setVictorys(int i) => _victorys = i;

  ///get how many loses have the person
  int get getLoses => _loses;
  //set loses
  set setLoses(int i) => _victorys = i;

  ///get if the person got it blackjack(21)
  bool get getBlackjack => _blackjack;
  //set blackjack
  set setBlackjack(bool b) => _blackjack = b;

  ///get dealer - return "true" case is dealer
  bool get getDealer => _dealer;

  /// Hit - add one more card in hand
  ///
  /// [value] - value of the new card
  void hitHand(String value) {
    getCards.add(value);
    setCardsValue = getCardsTotal;
    if (getCardsTotal > 21) {
      explodeHand();
    }
  }

  /// Split - separa as cartas e atribui um valor para cada mão cards
  void splitHand() {}

  /// Double - dobra a aposta e abre apenas uma carta
  ///
  ///[value] - value of the new card
  void doubleHand(String value) {
    hitHand(value);
    standHand();
  }

  /// Stand - stop a bit
  void standHand() => setStand = true;

  /// Explode - hand is above 21
  void explodeHand() => setExplode = true;

  /// Win - when the player win
  void win() => setVictorys = getVictorys + 1;

  /// Lose - when the player lose
  void lose() => setLoses = getLoses + 1;

  ///New round
  ///
  ///Reset the hand/attributes like [_explode], [_stand], [_cards], [_cardsValue] and [_blackjack]
  ///Already start the new round with values
  ///[d] - object type Deck
  void newRound(Deck d) {
    setExplode = false;
    setStand = false;
    setCards = [];
    setCardsValue = 0;
    setBlackjack = false;
  }

  ///Return the [cardsValue] of hand
  int get getCardsTotal {
    int aux = 0;
    int auxA = 0;
    for (int i = 0; i < getCards.length; i++) {
      switch (getCards[i][0]) {
        case "A":
          auxA++;
          aux += 11;
          break;
        case "2":
          aux += 2;
          break;
        case "3":
          aux += 3;
          break;
        case "4":
          aux += 4;
          break;
        case "5":
          aux += 5;
          break;
        case "6":
          aux += 6;
          break;
        case "7":
          aux += 7;
          break;
        case "8":
          aux += 8;
          break;
        case "9":
          aux += 9;
          break;
        case "1":
          aux += 10;
          break;
        case "J":
          aux += 10;
          break;
        case "Q":
          aux += 10;
          break;
        case "K":
          aux += 10;
          break;
        default:
          break;
      }
    }
    if (auxA != 0) {
      for (int i = auxA; i > 0; i--) {
        if (aux > 21) {
          aux -= 10;
        }
      }
    }
    return aux;
  }

  ///Return the [cardsValue] of hand
  int get getIndex1Value {
    int aux = 0;
    String card = getCards[1][0];
    switch (card) {
      case "A":
        aux += 11;
        break;
      case "2":
        aux += 2;
        break;
      case "3":
        aux += 3;
        break;
      case "4":
        aux += 4;
        break;
      case "5":
        aux += 5;
        break;
      case "6":
        aux += 6;
        break;
      case "7":
        aux += 7;
        break;
      case "8":
        aux += 8;
        break;
      case "9":
        aux += 9;
        break;
      case "1":
        aux += 10;
        break;
      case "J":
        aux += 10;
        break;
      case "Q":
        aux += 10;
        break;
      case "K":
        aux += 10;
        break;
      default:
        break;
    }

    return aux;
  }
}
