// import 'dart:async';
// import 'dart:math';

// import 'package:flutter/material.dart';
// import 'package:flutter/src/foundation/key.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:logging/logging.dart';
// import 'package:provider/provider.dart';
// import 'package:vingtun/style/button_style.dart';
// import 'package:vingtun/ui/menu_screen.dart';
// import 'package:vingtun/utils/Round.dart';
// import 'package:vingtun/utils/database.dart';
// import 'package:vingtun/utils/deck.dart';
// import 'package:vingtun/utils/person.dart';
// import 'package:vingtun/widgets/appbar.dart';
// import 'package:vingtun/widgets/game_coins.dart';
// import 'package:vingtun/widgets/a.dart';

// class GameScreen extends StatefulWidget {
//   const GameScreen({Key? key}) : super(key: key);

//   @override
//   State<GameScreen> createState() => _GameScreenState();
// }

// class _GameScreenState extends State<GameScreen> {
//   static final _log = Logger('GameController');

//   bool flag = true;
//   Deck deque = Deck(8);
//   Person player = Person("You", false);
//   Person dealer = Person("Dealer", true);
//   bool _showReplayButton = false;
//   late int _playerDefeatVictory;
//   late String _playerResultShow;
//   late double _progressValue;
//   late Color _colorPlayer;
//   late Color _colorDealer;
//   late bool _loadPage = false;
//   late double bit;
//   late bool playerWhitoutMoney;
//   bool doneWidget = false;

//   @override
//   void initState() {
//     super.initState();
//     _log.info("Size: ${deque.getDeck.length}");
//     player.newRound(deque);
//     dealer.newRound(deque);
//     player.hitHand(deque.openCard());
//     dealer.hitHand(deque.openCard());
//     player.hitHand(deque.openCard());
//     dealer.hitHand(deque.openCard());
//     _log.info("Player Cards: ${player.getCards}");
//     _progressValue = 0;
//     _colorDealer = Color(0xff090265);
//     _colorPlayer = Color(0xff090265);
//     bit = 20;
//     _playerResultShow = "BlackJack";
//     //This Future.delayed will make the page wait 2 seconds before loading it
//     Future.delayed(const Duration(milliseconds: 1000), () {
//       setState(() {
//         _loadPage = true;
//       });
//     });
//     playerWhitoutMoney = false;
//   }

//   ///Reset the round for a new match
//   void replay() {
//     setState(() {
//       player.newRound(deque);
//       dealer.newRound(deque);
//       player.hitHand(deque.openCard());
//       dealer.hitHand(deque.openCard());
//       player.hitHand(deque.openCard());
//       dealer.hitHand(deque.openCard());
//       _colorDealer = Color(0xff090265);
//       _colorPlayer = Color(0xff090265);
//       _playerResultShow = 'BlackJack';
//       Future.delayed(const Duration(seconds: 1), () {
//         doneWidget = !doneWidget;
//       });
//       // if (bit > player.getMoney) {
//       //   bit = 20;
//       // }
//       // if (player.getMoney < 20) {
//       //   print("You`re without money...");
//       //   playerWhitoutMoney = true;
//       // }
//     });
//   }

//   Color _colorResultShow(String s) {
//     if (s == "Victory") {
//       return Colors.green;
//     } else if (s == "Defeat") {
//       return Colors.red;
//     } else if (s == "Tie") {
//       return Colors.blue.shade200;
//     } else {
//       return Theme.of(context).accentColor;
//     }
//   }

//   void _updateProgress() {
//     const oneSec = Duration(milliseconds: 20);
//     Timer.periodic(oneSec, (Timer t) async {
//       setState(() {
//         _progressValue += 0.013;
//         if (_progressValue >= 1) {
//           _showReplayButton = false;
//           _progressValue = 0.0;
//           replay();
//           t.cancel();
//           return;
//         }
//       });
//     });
//   }

//   ///Function that analyzes and classifies the game, as well as is responsible for making the Dealer() movements;
//   void playGame(BuildContext context) {
//     if (player.getStand == true) {
//       while (!dealer.getStand && !dealer.getExplode) {
//         if (dealer.getCardsTotal > 16 && dealer.getCardsTotal < 22) {
//           dealer.standHand();
//           if (dealer.getCardsTotal > player.getCardsTotal) {
//             _log.info('Player lost');
//             _colorDealer = Colors.green;
//             _colorPlayer = Colors.red;
//             dealer.win();
//             player.lose();
//             _playerDefeatVictory = -1;
//             _playerResultShow = "Defeat";
//             // counter.currentCoins = counter.currentCoins - counter.betCoins;
//           } else if (dealer.getCardsTotal == player.getCardsTotal) {
//             _log.info('A tie');
//             _colorDealer = Colors.blue.shade200;
//             _colorPlayer = Colors.blue.shade200;
//             _playerDefeatVictory = 0;
//             _playerResultShow = "Tie";
//           } else {
//             _log.info('Dealer lost');
//             _colorDealer = Colors.red;
//             _colorPlayer = Colors.green;
//             player.win();
//             dealer.lose();
//             _playerDefeatVictory = 1;
//             _playerResultShow = "Victory";
//             // if (player.getCardsValue == 21) {
//             //   counter.currentCoins =
//             //       (counter.currentCoins + 1.5 * counter.betCoins) as int;
//             // } else {
//             //   counter.currentCoins = counter.currentCoins + counter.betCoins;
//             // }
//           }
//         } else {
//           var card = deque.openCard();
//           dealer.hitHand(card);
//           _log.info('Drawn $card');
//         }
//         if (dealer.getExplode) {
//           _log.info('Dealer lost');
//           _colorDealer = Colors.red;
//           _colorPlayer = Colors.green;
//           player.win();
//           dealer.lose();
//           _playerDefeatVictory = 1;
//           _playerResultShow = "Victory";
//           // if (player.getCardsValue == 21) {
//           //   counter.currentCoins =
//           //       (counter.currentCoins + 1.5 * counter.betCoins) as int;
//           // } else {
//           //   counter.currentCoins = counter.currentCoins + counter.betCoins;
//           // }
//           // if (player.getCardsValue == 21) {
//           //   player.setMoney = player.getMoney + 1.5 * bit;
//           // } else {
//           //   player.setMoney = player.getMoney + bit;
//           // }
//         }
//         if (dealer.getStand) print("DEALER ENCERROU");
//       }
//     } else if (player.getExplode) {
//       _log.info('Player lost');
//       _colorDealer = Colors.green;
//       _colorPlayer = Colors.red;
//       dealer.win();
//       player.lose();
//       _playerDefeatVictory = -1;
//       _playerResultShow = "Defeat";
//       // counter.currentCoins = counter.currentCoins - counter.betCoins;
//     }

//     addRoundDB(_playerDefeatVictory, player.getCardsValue, dealer.getCardsValue,
//         player.getCards);
//   }

//   ///This function adds the round information from the database, [state], [playerPoints], [dealerPoints], [playerCards]
//   void addRoundDB(
//       int state, int playerPoints, int dealerPoints, List playerCards) {
//     final newRound = Round(
//       id: Random().nextDouble(),
//       state: state,
//       playerPoints: playerPoints,
//       dealerPoints: dealerPoints,
//       playerCards: playerCards.toString(),
//     );

//     DbSQLite.insert('historic', newRound);
//   }

//   @override
//   Widget build(BuildContext context) {
//     final GameCoins counter = context.watch<GameCoins>();

//     return WillPopScope(
//       onWillPop: () async {
//         return false;
//       },
//       child: Scaffold(
//         appBar: CustomAppBar(),
//         body: SafeArea(
//           child: Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Stack(
//               children: [
//                 Column(
//                   children: [
//                     Row(
//                       children: [
//                         IconButton(
//                           onPressed: () {
//                             Navigator.pop(context);
//                           },
//                           icon: Icon(Icons.arrow_back),
//                         ),
//                         Spacer(),
//                         Text(counter.betCoins.toString()),
//                       ],
//                     ),
//                     const Spacer(),

//                     DealerHand(
//                       dealer: dealer,
//                       player: player,
//                       colorDealer: _colorDealer,
//                     ),
//                     const Spacer(),

//                     Text(_playerResultShow,
//                         style: Theme.of(context).textTheme.headline6?.copyWith(
//                             color: _colorResultShow(_playerResultShow))),
//                     const Spacer(),
//                     PlayerHand(player: player, colorPlayer: _colorPlayer),
//                     const Spacer(),
//                     doneWidget
//                         ? Row(
//                             children: [
//                               SmallButton(
//                                   text: 'Done',
//                                   onPressed: () {
//                                     Navigator.of(context, rootNavigator: true)
//                                         .push(PageRouteBuilder(
//                                             transitionDuration: Duration.zero,
//                                             pageBuilder: (context, animation1,
//                                                     animation2) =>
//                                                 MenuScreen()));
//                                   }),
//                               TextButton(
//                                 style: replayButtonStyle,
//                                 onPressed: () {
//                                   replay();
//                                   doneWidget = !doneWidget;
//                                 },
//                                 child: const Text('Replay'),
//                               ),
//                               IconButton(
//                                   onPressed: () {},
//                                   icon: const Icon(Icons.share))
//                             ],
//                           )
//                         : Column(
//                             mainAxisAlignment: MainAxisAlignment.spaceAround,
//                             children: <Widget>[
//                               Row(
//                                 children: [
//                                   if (player.getCardsTotal == 14) ...[
//                                     ButtonBlackjack(
//                                         text: 'Split', onPressed: () {})
//                                   ]
//                                 ],
//                               ),
//                               Row(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceAround,
//                                 children: [
//                                   ButtonBlackjack(
//                                     text: "Hit",
//                                     onPressed: !_showReplayButton &&
//                                             !playerWhitoutMoney
//                                         ? () {
//                                             setState(() {
//                                               player.hitHand(deque.openCard());
//                                               _log.info(
//                                                   'Hit! ${player.getCards.toString()}');

//                                               if (player.getExplode) {
//                                                 _showReplayButton = true;
//                                                 _colorPlayer = Colors.red;
//                                                 _playerDefeatVictory = -1;
//                                                 _playerResultShow = "Defeat";
//                                                 counter.currentCoins =
//                                                     counter.currentCoins -
//                                                         counter.betCoins;
//                                                 Future.delayed(
//                                                     const Duration(seconds: 1),
//                                                     () {
//                                                   doneWidget = !doneWidget;
//                                                 });

//                                                 addRoundDB(
//                                                   _playerDefeatVictory,
//                                                   player.getCardsValue,
//                                                   dealer.getCardsValue,
//                                                   player.getCards,
//                                                 );
//                                                 _updateProgress();
//                                               }
//                                               if (player.getBlackjack == true) {
//                                                 player.standHand();
//                                               }
//                                             });
//                                           }
//                                         : null,
//                                   ),
//                                   CircleButton(
//                                     text: "x2",
//                                     onPressed: !_showReplayButton &&
//                                             !playerWhitoutMoney
//                                         ? () {
//                                             setState(() {
//                                               counter.betCoins =
//                                                   counter.betCoins * 2;
//                                               player.getCards
//                                                   .add(deque.openCard());
//                                               if (player.getExplode) {
//                                                 _showReplayButton = true;
//                                                 _colorPlayer = Colors.red;
//                                                 _playerDefeatVictory = -1;
//                                                 _playerResultShow = "Defeat";
//                                               }
//                                               if (deque.openCard() == 10) {
//                                                 player.getExplode;
//                                               }

//                                               player.standHand();
//                                               playGame(context);
//                                               _showReplayButton = true;
//                                               _updateProgress();
//                                               print("Foi! " +
//                                                   dealer.getCards.toString());

//                                               if (player.getBlackjack == true) {
//                                                 player.standHand();
//                                               }
//                                             });
//                                           }
//                                         : null,
//                                   ),
//                                   ButtonBlackjack(
//                                     text: "Stand",
//                                     onPressed: !_showReplayButton &&
//                                             !playerWhitoutMoney
//                                         ? () {
//                                             setState(() {
//                                               player.standHand();
//                                               playGame(context);

//                                               _showReplayButton = true;
//                                               _updateProgress();
//                                             });
//                                           }
//                                         : null,
//                                   ),
//                                 ],
//                               ),
//                             ],
//                           )
//                     // Row(
//                     //   mainAxisAlignment: MainAxisAlignment.spaceAround,
//                     //   children: <Widget>[
//                     //     ButtonBlackjack(
//                     //       name: "Split",
//                     //       color: Colors.blue.shade400,
//                     //       function: !_showReplayButton && !playerWhitoutMoney
//                     //           ? () {
//                     //               setState(() {
//                     //                 player.getCards.add(deque.openCard());
//                     //                 // Future<String> test = deque.openCard();
//                     //                 print("Foi! " + player.getCards.toString());
//                     //                 // print("Esse teste " + test.toString());
//                     //               });
//                     //             }
//                     //           : null,
//                     //     ),
//                     //   ],
//                     // ),
//                     //// TextButton(
//                     ////     onPressed: () {
//                     ////       showDataAlert();
//                     ////     },
//                     //// child: Text('tt')),
//                     // AnimatedSwitcher(
//                     //     duration: Duration(milliseconds: 1000),
//                     //     child: flag
//                     //         ? TextButton(
//                     //             style: dealButtonStyle,
//                     //             onPressed: () => setState(() => flag = !flag),
//                     //             child: Text('hooh'))
//                     //         : ElevatedButton(
//                     //             onPressed: () {}, child: Text('dooooo'))),
//                   ],
//                 ),
//                 _showReplayButton
//                     ? LinearProgressIndicator(
//                         value: _progressValue,
//                       )
//                     : Container(),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
