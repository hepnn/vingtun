import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vingtun/utils/person.dart';

class PlayerHand extends StatelessWidget {
  final Person player;

  const PlayerHand({Key? key, required this.player}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(10)),
      child: Stack(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.only(top: 20, left: 140),
            height: 150,
            child: player.getCards.isEmpty
                ? const Center(child: Text("Error"))
                : Stack(
                    children: [
                      for (int i = 0; i < player.getCards.length; i++)
                        Positioned(
                          left: i.toDouble() * 60,
                          child: SvgPicture.asset(
                            'assets/cards/${player.getCards[i]}.svg',
                            width: 100,
                            height: 110,
                            fit: BoxFit.fill,
                          ),
                        ),
                    ],
                  ),
          ),
          Align(
            alignment: Alignment.topRight,
            child: Container(
              height: 30,
              width: 30,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.black38),
              child: Text(
                player.getCardsTotal.toString(),
                style: const TextStyle(fontSize: 20),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class DealerHand extends StatelessWidget {
  final Person dealer;
  final Person player;

  const DealerHand({
    Key? key,
    required this.dealer,
    required this.player,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(10)),
      child: Stack(
        children: [
          Container(
            padding: const EdgeInsets.only(top: 20, left: 140),
            height: 150,
            child: !player.getExplode && !player.getStand
                ? Stack(
                    children: [
                      Positioned(
                        left: 0,
                        child: SvgPicture.asset(
                          'assets/cards/${dealer.getCards[0]}.svg',
                          width: 100,
                          height: 110,
                        ),
                      ),
                      Positioned(
                        left: 30,
                        child: SvgPicture.asset(
                          'assets/cards/back.svg',
                          width: 100,
                          height: 110,
                        ),
                      ),
                    ],
                  )
                : Stack(
                    children: [
                      for (int i = 0; i < dealer.getCards.length; i++)
                        Positioned(
                          left: i.toDouble() * 30,
                          child: SvgPicture.asset(
                            'assets/cards/${dealer.getCards[i]}.svg',
                            width: 100,
                            height: 110,
                          ),
                        ),
                    ],
                  ),
          ),
          Align(
            alignment: Alignment.topRight,
            child: Container(
              height: 30,
              width: 30,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.black38,
              ),
              child: !player.getExplode && !player.getStand
                  ? Text(
                      (dealer.getCardsValue - dealer.getIndex1Value).toString())
                  : Text(
                      dealer.getCardsValue.toString(),
                      style: const TextStyle(fontSize: 20),
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
