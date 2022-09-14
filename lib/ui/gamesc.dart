import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:vingtun/settings/theme_provider.dart';
import 'package:vingtun/style/button_style.dart';
import 'package:vingtun/utils/Round.dart';
import 'package:vingtun/utils/database.dart';
import 'package:vingtun/utils/deck.dart';
import 'package:vingtun/utils/person.dart';
import 'package:vingtun/widgets/a.dart';
import 'package:vingtun/widgets/appbar.dart';
import 'package:vingtun/widgets/game_coins.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({Key? key}) : super(key: key);

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  late bool playerWithoutMoney;
  late String _playerResultShow;
  late int _playerDefeatVictory;

  late double _progressValue;

  late bool _loadPage = false;

  Deck deque = Deck(8);

  Person player = Person("You", false);
  Person dealer = Person("Dealer", true);

  @override
  void initState() {
    playerWithoutMoney = false;
    _playerResultShow = "Make your move";
    _progressValue = 0;

    player.newRound(deque);
    dealer.newRound(deque);
    player.hitHand(deque.openCard());
    dealer.hitHand(deque.openCard());
    player.hitHand(deque.openCard());
    dealer.hitHand(deque.openCard());
    Future.delayed(const Duration(milliseconds: 1000), () {
      setState(() {
        _loadPage = true;
      });
    });
    super.initState();
  }

  void _updateProgress() {
    const oneSec = Duration(milliseconds: 20);
    Timer.periodic(oneSec, (Timer t) async {
      setState(() {
        _progressValue += 0.013;
        if (_progressValue >= 1) {
          _progressValue = 0.0;
          replay();
          t.cancel();
          return;
        }
      });
    });
  }

  void replay() {
    setState(() {
      player.newRound(deque);
      dealer.newRound(deque);
      player.hitHand(deque.openCard());
      dealer.hitHand(deque.openCard());
      player.hitHand(deque.openCard());
      dealer.hitHand(deque.openCard());
      _playerResultShow = 'Make your move';
    });
  }

  void playGame() {
    if (player.getStand == true) {
      while (!dealer.getStand && !dealer.getExplode) {
        if (dealer.getCardsTotal > 16 && dealer.getCardsTotal < 22) {
          dealer.standHand();
          if (dealer.getCardsTotal > player.getCardsTotal) {
            dealer.win();
            player.lose();
            _playerDefeatVictory = -1;
            _playerResultShow = "Defeat";
          } else if (dealer.getCardsTotal == player.getCardsTotal) {
            _playerDefeatVictory = 0;
            _playerResultShow = "Tie";
          } else {
            player.win();
            dealer.lose();
            _playerDefeatVictory = 1;
            _playerResultShow = "Victory";
            if (player.getCardsValue == 21) {}
          }
        } else {
          var card = deque.openCard();
          dealer.hitHand(card);
        }
        if (dealer.getExplode) {
          player.win();
          dealer.lose();
          _playerDefeatVictory = 1;
          _playerResultShow = "Victory";
          if (player.getCardsValue == 21) {}
        }
      }
    } else if (player.getExplode) {
      dealer.win();
      player.lose();
      _playerDefeatVictory = -1;
      _playerResultShow = "Defeat";
    }

    addRoundDB(_playerDefeatVictory, player.getCardsValue, dealer.getCardsValue,
        player.getCards);
  }

  void addRoundDB(
      int state, int playerPoints, int dealerPoints, List playerCards) {
    final newRound = Round(
      id: Random().nextDouble(),
      state: state,
      playerPoints: playerPoints,
      dealerPoints: dealerPoints,
      playerCards: playerCards.toString(),
    );
    DbSQLite.insert('historic', newRound);
  }

  @override
  Widget build(BuildContext context) {
    var theme = Provider.of<ThemeProvider>(context).themeMode == ThemeMode.dark;
    Color themeColor = theme ? Colors.white : Colors.black;

    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        appBar: const CustomAppBar(),
        body: SafeArea(
          child: Stack(
            children: [
              _loadPage
                  ? Column(
                      children: [
                        Row(
                          children: [
                            IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: const Icon(Icons.arrow_back),
                            ),
                            const Spacer(),
                            // Text(counter.betCoins.toString()),
                          ],
                        ),
                        const Spacer(),
                        DealerHand(dealer: dealer, player: player),
                        const Spacer(),
                        Text(_playerResultShow),
                        const Spacer(),
                        PlayerHand(player: player),
                        const Spacer(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            SmallButton(
                                text: 'Hit',
                                onPressed: !playerWithoutMoney
                                    ? () {
                                        setState(() {
                                          player.hitHand(deque.openCard());
                                          if (player.getExplode) {
                                            _playerDefeatVictory = -1;
                                            _playerResultShow = 'Lost';
                                            addRoundDB(
                                              _playerDefeatVictory,
                                              player.getCardsValue,
                                              dealer.getCardsValue,
                                              player.getCards,
                                            );
                                            _updateProgress();
                                          }
                                          if (player.getBlackjack == true) {
                                            player.standHand();
                                          }
                                        });
                                      }
                                    : null),
                            CircleButton(
                              text: 'x2',
                              onPressed: !playerWithoutMoney ? () {} : null,
                            ),
                            SmallButton(
                              text: 'Stand',
                              onPressed: !playerWithoutMoney
                                  ? () {
                                      setState(() {
                                        player.standHand();
                                        playGame();
                                        _updateProgress();
                                      });
                                    }
                                  : null,
                            ),
                          ],
                        ),
                        Spacer(),
                      ],
                    )
                  : Center(
                      child: CircularProgressIndicator(
                      color: themeColor,
                    )),
            ],
          ),
        ),
      ),
    );
  }
}
