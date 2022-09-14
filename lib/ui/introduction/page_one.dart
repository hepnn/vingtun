import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class PageOne extends StatelessWidget {
  const PageOne({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text('How do you beat the dealer?',
              style: Theme.of(context).textTheme.bodyLarge),
        ),
        const Text(
            '• By drawing a hand value that is higher than the dealers hand value \n• By the dealer drawing a hand value that goes over 21. \n• By drawing a hand value of 21 on your first two cards, when the dealer does not.'),
        Align(
          alignment: Alignment.centerLeft,
          child: Text('How do you lose to the dealer?',
              style: Theme.of(context).textTheme.bodyLarge),
        ),
        Text(
            '• Your hand value exceeds 21. \n• The dealers hand has a greater value than yours at the end of the round'),
      ],
    );
  }
}
