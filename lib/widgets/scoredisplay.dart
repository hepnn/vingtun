import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vingtun/viewmodel/dealer.dart';
import 'package:vingtun/viewmodel/player.dart';

class ScoreDisplay extends StatelessWidget {
  const ScoreDisplay({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final player = Provider.of<Player>(context);
    return Align(
      alignment: Alignment.topRight,
      child: Text(
        player.playerNum.toString(),
        style: const TextStyle(
          fontSize: 25.0,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class ScoreDisplayD extends StatelessWidget {
  const ScoreDisplayD({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dealer = Provider.of<Dealer>(context, listen: false);
    return Align(
      alignment: Alignment.topRight,
      child: Text(
        dealer.dealerNum.toString(),
        style: const TextStyle(
          fontSize: 25.0,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
