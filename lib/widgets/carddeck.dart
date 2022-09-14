import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vingtun/models/cardback.dart';
import 'package:vingtun/viewmodel/numcard.dart';
import 'package:vingtun/widgets/cardtemplate.dart';
import 'package:vingtun/widgets/scoredisplay.dart';

class CardDeckD extends StatelessWidget {
  const CardDeckD({
    Key? key,
    required this.card6,
    required this.card7,
    required this.card8,
    required this.card9,
    required this.card10,
    required this.hasWon,
  }) : super(key: key);

  final bool card6;
  final bool card7;
  final bool card8;
  final bool card9;
  final bool card10;
  final bool hasWon;

  @override
  Widget build(BuildContext context) {
    final numCard = Provider.of<NumCard>(context);

    return Stack(
      children: [
        Row(
          children: [
            card6
                ? Visibility(
                    visible: card6,
                    child: CardTemplate(
                      flower: numCard.flower6,
                      num: numCard.num6,
                      color: numCard.color6,
                    ),
                  )
                : const CardBack(),
            card7
                ? Visibility(
                    visible: card7,
                    child: CardTemplate(
                      flower: numCard.flower7,
                      num: numCard.num7,
                      color: numCard.color7,
                    ),
                  )
                : const CardBack(),
            card8
                ? Visibility(
                    visible: card8,
                    child: CardTemplate(
                      flower: numCard.flower8,
                      num: numCard.num8,
                      color: numCard.color8,
                    ),
                  )
                : const CardBack(),
            card9
                ? Visibility(
                    visible: card9,
                    child: CardTemplate(
                      flower: numCard.flower9,
                      num: numCard.num9,
                      color: numCard.color9,
                    ),
                  )
                : const CardBack(),
            card10
                ? Visibility(
                    visible: card10,
                    child: CardTemplate(
                      flower: numCard.flower10,
                      num: numCard.num10,
                      color: numCard.color10,
                    ),
                  )
                : const CardBack(),
          ],
        ),
        //dealerNum text
        ScoreDisplayD(),
      ],
    );
  }
}
