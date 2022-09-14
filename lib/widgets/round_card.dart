import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

///Esqueleto de Card de rodada, que mostra os dados de uma partida.
class RoundCard extends StatelessWidget {
  final int state;
  final int playerPoints;
  final int dealerPoints;
  final String cards;

  Color? colorRound(int i) {
    // print("Esse é o valor do state: $i");
    if (i == -1) {
      //defeat
      return Colors.red.shade300;
    } else if (i == 0) {
      //tie
      return Colors.blue.shade300;
    } else if (i == 1) {
      //victory
      return Colors.green.shade300;
    } else {
      return null;
    }
  }

  List<String> readCards(String s) {
    List<String> aux = [];
    for (int count = 0; count < s.length - 1; count++) {
      if (s[count] == '[' ||
          s[count] == ' ' ||
          s[count] == ',' ||
          s[count] == ']') {
      } else {
        switch (s[count]) {
          case 'A':
            aux.add("A${checkSuit(s[count + 1])}");
            break;
          case '2':
            aux.add("2${checkSuit(s[count + 1])}");
            break;
          case '3':
            aux.add("3${checkSuit(s[count + 1])}");
            break;
          case '4':
            aux.add("4${checkSuit(s[count + 1])}");
            break;
          case '5':
            aux.add("5${checkSuit(s[count + 1])}");
            break;
          case '6':
            aux.add("6${checkSuit(s[count + 1])}");
            break;
          case '7':
            aux.add("7${checkSuit(s[count + 1])}");
            break;
          case '8':
            aux.add("8${checkSuit(s[count + 1])}");
            break;
          case '9':
            aux.add("9${checkSuit(s[count + 1])}");
            break;
          case '1':
            aux.add("10${checkSuit(s[count + 2])}");
            break;
          case 'J':
            aux.add("J${checkSuit(s[count + 1])}");
            break;
          case 'Q':
            aux.add("Q${checkSuit(s[count + 1])}");
            break;
          case 'K':
            aux.add("K${checkSuit(s[count + 1])}");
            break;
        }
      }
    }
    return aux;
  }

  String? checkSuit(String s) {
    switch (s) {
      case 'C':
        return 'C';
      case 'D':
        return 'D';
      case 'H':
        return 'H';
      case 'S':
        return 'H';
      default:
        return null;
    }
  }

  ///Used to show a round already finished in historic
  const RoundCard(this.state, this.cards, this.playerPoints, this.dealerPoints,
      {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    List roundCards = readCards(cards);

    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: colorRound(state),
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(5),
      ),
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
      height: 70,
      width: MediaQuery.of(context).size.width - 130,
      child: Stack(
        children: <Widget>[
          Stack(
            children: [
              for (int i = 0; i < roundCards.length; i++)
                Positioned(
                  left: i.toDouble() * 20,
                  child: SvgPicture.asset(
                    'assets/cards/${roundCards[i]}.svg',
                    width: 100,
                    height: 70,
                  ),
                ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "You",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  Text("$playerPoints",
                      style: const TextStyle(
                          color: Color(0xff090265),
                          fontWeight: FontWeight.bold)),
                ],
              ),
              Container(
                width: 2,
                height: 40,
                color: Colors.white,
                margin: const EdgeInsets.symmetric(horizontal: 5),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "Dealer",
                    style: TextStyle(
                      color: Colors.grey[100],
                    ),
                  ),
                  Text(
                    "$dealerPoints",
                    style: const TextStyle(color: Color(0xff090265)),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
