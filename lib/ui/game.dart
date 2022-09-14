// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'dart:math';

// import 'package:provider/provider.dart';
// import 'package:vingtun/models/cards.dart';
// import 'package:vingtun/models/constants.dart';
// import 'package:vingtun/style/button_style.dart';
// import 'package:vingtun/viewmodel/dealer.dart';
// import 'package:vingtun/viewmodel/numcard.dart';
// import 'package:vingtun/viewmodel/player.dart';
// import 'package:vingtun/widgets/appbar.dart';
// import 'package:vingtun/widgets/carddeck.dart';
// import 'package:vingtun/widgets/cardtemplate.dart';
// import 'package:vingtun/widgets/game_coins.dart';
// import 'package:vingtun/widgets/playerchangeabbutton.dart';
// import 'package:vingtun/widgets/roundendtext.dart';
// import 'package:vingtun/widgets/scoredisplay.dart';

// class GameScreen extends StatefulWidget {
//   const GameScreen({Key? key}) : super(key: key);

//   @override
//   State<GameScreen> createState() => _GameScreenState();
// }

// class _GameScreenState extends State<GameScreen> {
//   var constantsVal = Condition();
//   static const rngMax = 52;
//   int rngNum = 0;
//   int rngDealer = 0;
//   String endingText = 'Please start';
//   int counter = 2;
//   var card = Cards();
//   List<int> usedNum = [];
//   bool card1 = false;
//   bool card2 = false;
//   bool card3 = false;
//   bool card4 = false;
//   bool card5 = false;
//   bool card6 = false;
//   bool card7 = false;
//   bool card8 = false;
//   bool card9 = false;
//   bool card10 = false;
//   bool shouldDisableButton = false;
//   bool firstButtonClick = false;
//   bool hasWon = false;
//   bool hasBeenPressed = false;
//   bool hasBeenPressed2 = false;
//   bool hasBeenPressed3 = false;
//   bool hasBeenPressed4 = false;
//   bool hasBeenPressed5 = false;

//   //restarts the current game with new session

//   void restartGame() {
//     setState(() {
//       card.userVal = 0;
//       card1 = false;
//       card2 = false;
//       card3 = false;
//       card4 = false;
//       card5 = false;
//       card6 = false;
//       card7 = false;
//       card8 = false;
//       card9 = false;
//       card10 = false;
//       usedNum = [];
//       shouldDisableButton = false;
//       firstButtonClick = false;
//       endingText = 'Please start';
//       hasWon = false;
//       hasBeenPressed = false;
//       hasBeenPressed2 = false;
//       hasBeenPressed3 = false;
//       hasBeenPressed4 = false;
//       hasBeenPressed5 = false;
//     });
//   }

//   //show player cards
//   void numOfCards(int num) {
//     switch (num) {
//       case 1:
//         card1 = true;
//         break;
//       case 2:
//         card2 = true;
//         break;
//       case 3:
//         card3 = true;
//         break;
//       case 4:
//         card4 = true;
//         break;
//       case 5:
//         card5 = true;
//         break;
//     }
//   }

//   //show dealer's cards
//   void numOfCardsDealer(int num) {
//     switch (num) {
//       case 1:
//         card6 = true;
//         break;
//       case 2:
//         card6 = true;
//         card7 = true;
//         break;
//       case 3:
//         card6 = true;
//         card7 = true;
//         card8 = true;
//         break;
//       case 4:
//         card6 = true;
//         card7 = true;
//         card8 = true;
//         card9 = true;
//         break;
//       case 5:
//         card6 = true;
//         card7 = true;
//         card8 = true;
//         card9 = true;
//         card10 = true;
//         break;
//     }
//   }

//   //make card A value change
//   void changeCardAValue(Player player, int input) {
//     hasBeenPressed = !hasBeenPressed;

//     switch (input) {
//       case 1:
//         player.changeA1 = !player.changeA1;
//         player.modifyA1Val();
//         break;
//       case 2:
//         player.changeA2 = !player.changeA2;
//         player.modifyA2Val();
//         break;
//       case 3:
//         player.changeA3 = !player.changeA3;
//         player.modifyA3Val();
//         break;
//       case 4:
//         player.changeA4 = !player.changeA4;
//         player.modifyA4Val();
//         break;
//       case 5:
//         player.changeA5 = !player.changeA5;
//         player.modifyA5Val();
//         break;
//     }
//   }

//   //when either player/dealer health goes 0
//   void endDecision(Player player, BuildContext context, Dealer dealer) async {
//     if (player.playerHealth <= 0) {
//       Navigator.pushReplacementNamed(context, '/gameover',
//           arguments: {'decision': 'lose'});
//     } else if (dealer.dealerHealth <= 0) {
//       Navigator.pushReplacementNamed(context, '/gameover',
//           arguments: {'decision': 'win'});
//     }
//   }

//   //things to do when SCORE CALCULATION
//   Future thingsToDo(String text, Player player, Dealer dealer) async {
//     setState(() {
//       shouldDisableButton = true;
//       endingText = text;
//       hasWon = true;
//     });
//     //auto restart after x seconds
//     await Future.delayed(Duration(seconds: counter));
//     setState(() => hasWon = false);
//     restartGame();
//     player.restartStats();
//     dealer.restartDealerStats();
//   }

//   //update player cards - hit button
//   void updatePlayerCards(Player player, NumCard numCard, Dealer dealer) {
//     switch (player.playerCard.length) {
//       case 3:
//         numCard.doSomething3(card.flowerVal, card.cardNum, card.cardColor);
//         break;
//       case 4:
//         numCard.doSomething4(card.flowerVal, card.cardNum, card.cardColor);
//         break;
//       case 5:
//         numCard.doSomething5(card.flowerVal, card.cardNum, card.cardColor);
//         numOfCardsDealer(dealer.dealerCard.length);
//         break;
//     }
//   }

//   //update dealer cards - hold button
//   void updateDealerCards(Dealer dealer, NumCard numCard) {
//     switch (dealer.dealerCard.length) {
//       case 3:
//         numCard.doSomething8(card.flowerVal, card.cardNum, card.cardColor);
//         break;
//       case 4:
//         numCard.doSomething9(card.flowerVal, card.cardNum, card.cardColor);
//         break;
//       case 5:
//         numCard.doSomething10(card.flowerVal, card.cardNum, card.cardColor);
//         break;
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final GameCoins coinBank = context.watch<GameCoins>();

//     return MultiProvider(
//       providers: [
//         ChangeNotifierProvider<NumCard>(create: (context) => NumCard()),
//         ChangeNotifierProvider<Player>(create: (context) => Player()),
//         ChangeNotifierProvider<Dealer>(create: (context) => Dealer()),
//       ],
//       child: Scaffold(
//         appBar: CustomAppBar(),
//         body: SafeArea(
//           child: Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Center(
//               child: Stack(
//                 children: [
//                   //main widgets
//                   Column(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       IconButton(
//                         onPressed: () {
//                           Navigator.pop(context);
//                         },
//                         icon: Icon(Icons.arrow_back),
//                       ),
//                       //dealer's health bar

//                       const SizedBox(height: 5.0),
//                       //dealer's cards and dealerNum

//                       CardDeckD(
//                           card6: card6,
//                           card7: card7,
//                           card8: card8,
//                           card9: card9,
//                           card10: card10,
//                           hasWon: hasWon),
//                       //start hold hit button
//                       Consumer2<NumCard, Player>(
//                           builder: (context, numCard, player, child) {
//                         return Stack(
//                           children: [
//                             Row(
//                               mainAxisSize: MainAxisSize.min,
//                               children: [
//                                 card1
//                                     ? Visibility(
//                                         visible: card1,
//                                         child: Column(
//                                           children: [
//                                             CardTemplate(
//                                               flower: numCard.flower,
//                                               num: numCard.num,
//                                               color: numCard.color,
//                                             ),
//                                             Visibility(
//                                               maintainState: true,
//                                               maintainAnimation: true,
//                                               maintainSize: true,
//                                               visible:
//                                                   player.playerCard[0] == 'A',
//                                               child: IconButton(
//                                                   color: hasBeenPressed
//                                                       ? Colors.black
//                                                       : Colors.green,
//                                                   icon:
//                                                       const Icon(Icons.cached),
//                                                   onPressed: hasWon
//                                                       ? null
//                                                       : () {
//                                                           changeCardAValue(
//                                                               player, 1);
//                                                         }),
//                                             ),
//                                           ],
//                                         ),
//                                       )
//                                     : const PlayerChangeAButton(),
//                                 card2
//                                     ? Visibility(
//                                         visible: card2,
//                                         child: Column(
//                                           children: [
//                                             CardTemplate(
//                                               flower: numCard.flower2,
//                                               num: numCard.num2,
//                                               color: numCard.color2,
//                                             ),
//                                             Visibility(
//                                               maintainState: true,
//                                               maintainAnimation: true,
//                                               maintainSize: true,
//                                               visible:
//                                                   player.playerCard[1] == 'A',
//                                               child: IconButton(
//                                                   color: hasBeenPressed2
//                                                       ? Colors.black
//                                                       : Colors.green,
//                                                   icon:
//                                                       const Icon(Icons.cached),
//                                                   onPressed: hasWon
//                                                       ? null
//                                                       : () {
//                                                           changeCardAValue(
//                                                               player, 2);
//                                                         }),
//                                             ),
//                                           ],
//                                         ),
//                                       )
//                                     : const PlayerChangeAButton(),
//                                 card3
//                                     ? Visibility(
//                                         visible: card3,
//                                         child: Column(
//                                           children: [
//                                             CardTemplate(
//                                               flower: numCard.flower3,
//                                               num: numCard.num3,
//                                               color: numCard.color3,
//                                             ),
//                                             Visibility(
//                                               maintainState: true,
//                                               maintainAnimation: true,
//                                               maintainSize: true,
//                                               visible:
//                                                   player.playerCard[2] == 'A',
//                                               child: IconButton(
//                                                   color: hasBeenPressed3
//                                                       ? Colors.black
//                                                       : Colors.green,
//                                                   icon:
//                                                       const Icon(Icons.cached),
//                                                   onPressed: hasWon
//                                                       ? null
//                                                       : () {
//                                                           changeCardAValue(
//                                                               player, 3);
//                                                         }),
//                                             ),
//                                           ],
//                                         ),
//                                       )
//                                     : const PlayerChangeAButton(),
//                                 card4
//                                     ? Visibility(
//                                         visible: card4,
//                                         child: Column(
//                                           children: [
//                                             CardTemplate(
//                                               flower: numCard.flower4,
//                                               num: numCard.num4,
//                                               color: numCard.color4,
//                                             ),
//                                             Visibility(
//                                               maintainState: true,
//                                               maintainAnimation: true,
//                                               maintainSize: true,
//                                               visible:
//                                                   player.playerCard[3] == 'A',
//                                               child: IconButton(
//                                                   color: hasBeenPressed4
//                                                       ? Colors.black
//                                                       : Colors.green,
//                                                   icon:
//                                                       const Icon(Icons.cached),
//                                                   onPressed: hasWon
//                                                       ? null
//                                                       : () {
//                                                           changeCardAValue(
//                                                               player, 4);
//                                                         }),
//                                             ),
//                                           ],
//                                         ),
//                                       )
//                                     : const PlayerChangeAButton(),
//                                 card5
//                                     ? Visibility(
//                                         visible: card5,
//                                         child: Column(
//                                           children: [
//                                             CardTemplate(
//                                               flower: numCard.flower5,
//                                               num: numCard.num5,
//                                               color: numCard.color5,
//                                             ),
//                                             Visibility(
//                                               maintainState: true,
//                                               maintainAnimation: true,
//                                               maintainSize: true,
//                                               visible:
//                                                   player.playerCard[4] == 'A',
//                                               child: IconButton(
//                                                   color: hasBeenPressed5
//                                                       ? Colors.black
//                                                       : Colors.green,
//                                                   icon:
//                                                       const Icon(Icons.cached),
//                                                   onPressed: hasWon
//                                                       ? null
//                                                       : () {
//                                                           changeCardAValue(
//                                                               player, 5);
//                                                         }),
//                                             ),
//                                           ],
//                                         ),
//                                       )
//                                     : const PlayerChangeAButton(),
//                               ],
//                             ),
//                             //playerNum text
//                             const ScoreDisplay(),
//                           ],
//                         );
//                       }),
//                       //player's cards and playerNum
//                       Consumer3<NumCard, Player, Dealer>(
//                           builder: (context, numCard, player, dealer, child) {
//                         return Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                           children: [
//                             //start button
//                             ElevatedButton(
//                               child: const Text('Start'),
//                               onPressed: firstButtonClick
//                                   ? null
//                                   : () {
//                                       setState(
//                                           () => endingText = 'Competing..');
//                                       //as long as the card is not 4 and the val is less than 21, it rerolls
//                                       while (player.playerCard.length != 2) {
//                                         setState(() =>
//                                             rngNum = Random().nextInt(rngMax));

//                                         while (usedNum.contains(rngNum)) {
//                                           setState(() => rngNum =
//                                               Random().nextInt(rngMax));
//                                         }

//                                         if (usedNum.contains(rngNum) == false) {
//                                           //makes sure everyone is getting dealed before ending with dealer
//                                           switch (dealer.dealerCard.length) {
//                                             case 0:
//                                               //player's first turn for cards
//                                               card.takeCards(rngNum);
//                                               //ensures card val 'A' is 11
//                                               if (rngNum == 0 ||
//                                                   rngNum == 1 ||
//                                                   rngNum == 2 ||
//                                                   rngNum == 3) {
//                                                 card.cardVal = 1;
//                                                 player.updatePlayerNum(
//                                                     card.cardVal);
//                                               } else {
//                                                 player.updatePlayerNum(
//                                                     card.cardVal);
//                                               }
//                                               player.updatePlayerCard(
//                                                   card.cardNum);
//                                               usedNum.add(rngNum);

//                                               //updates first card of player
//                                               numCard.doSomething(
//                                                   card.flowerVal,
//                                                   card.cardNum,
//                                                   card.cardColor);

//                                               //rerolls for dealer's card
//                                               setState(() => rngNum =
//                                                   Random().nextInt(rngMax));

//                                               //check if its duplicate
//                                               while (usedNum.contains(rngNum)) {
//                                                 setState(() => rngNum =
//                                                     Random().nextInt(rngMax));
//                                               }

//                                               if (usedNum.contains(rngNum) ==
//                                                   false) {
//                                                 //dealer's first card
//                                                 card.takeCards(rngNum);
//                                                 //ensures card val 'A' is 11
//                                                 if (rngNum == 0 ||
//                                                     rngNum == 1 ||
//                                                     rngNum == 2 ||
//                                                     rngNum == 3) {
//                                                   card.cardVal = 11;
//                                                   dealer.updateDealerNum(
//                                                       card.cardVal);
//                                                 } else {
//                                                   dealer.updateDealerNum(
//                                                       card.cardVal);
//                                                 }
//                                                 dealer.updateDealerCard(
//                                                     card.cardNum);
//                                                 usedNum.add(rngNum);
//                                               }

//                                               //updates first card of dealer
//                                               numCard.doSomething6(
//                                                   card.flowerVal,
//                                                   card.cardNum,
//                                                   card.cardColor);

//                                               break;
//                                             case 1:
//                                               //player's second turn for cards
//                                               card.takeCards(rngNum);

//                                               //ensures card val 'A' is 11
//                                               if (rngNum == 0 ||
//                                                   rngNum == 1 ||
//                                                   rngNum == 2 ||
//                                                   rngNum == 3) {
//                                                 card.cardVal = 1;
//                                                 player.updatePlayerNum(
//                                                     card.cardVal);
//                                               } else {
//                                                 player.updatePlayerNum(
//                                                     card.cardVal);
//                                               }
//                                               player.updatePlayerCard(
//                                                   card.cardNum);
//                                               usedNum.add(rngNum);

//                                               //updates 2nd card for player
//                                               numCard.doSomething2(
//                                                   card.flowerVal,
//                                                   card.cardNum,
//                                                   card.cardColor);

//                                               //2nd turn for dealer
//                                               setState(() => rngNum =
//                                                   Random().nextInt(rngMax));

//                                               //check if its duplicate
//                                               while (usedNum.contains(rngNum)) {
//                                                 setState(() => rngNum =
//                                                     Random().nextInt(rngMax));
//                                               }

//                                               if (usedNum.contains(rngNum) ==
//                                                   false) {
//                                                 //dealer's second card
//                                                 card.takeCards(rngNum);

//                                                 //ensures card val 'A' is 11
//                                                 if (rngNum == 0 ||
//                                                     rngNum == 1 ||
//                                                     rngNum == 2 ||
//                                                     rngNum == 3) {
//                                                   if (dealer.dealerNum <
//                                                       11) // 10, 9, 8..
//                                                   {
//                                                     card.cardVal = 11;
//                                                     dealer.updateDealerNum(
//                                                         card.cardVal);
//                                                   } else if (dealer.dealerNum ==
//                                                       11) {
//                                                     card.cardVal = 10;
//                                                     dealer.updateDealerNum(
//                                                         card.cardVal);
//                                                   } else {
//                                                     card.cardVal = 1;
//                                                     dealer.updateDealerNum(
//                                                         card.cardVal);
//                                                   }
//                                                 } else {
//                                                   dealer.updateDealerNum(
//                                                       card.cardVal);
//                                                 }
//                                                 dealer.updateDealerCard(
//                                                     card.cardNum);
//                                                 usedNum.add(rngNum);

//                                                 //updates second card of dealer
//                                                 numCard.doSomething7(
//                                                     card.flowerVal,
//                                                     card.cardNum,
//                                                     card.cardColor);

//                                                 //checks if both double 'A'
//                                                 if (player
//                                                             .playerCard[0] ==
//                                                         'A' &&
//                                                     player
//                                                             .playerCard[1] ==
//                                                         'A' &&
//                                                     dealer.dealerCard[0] ==
//                                                         'A' &&
//                                                     dealer.dealerCard[1] ==
//                                                         'A') {
//                                                   thingsToDo(
//                                                       constantsVal.doubleADraw,
//                                                       player,
//                                                       dealer);
//                                                   numOfCardsDealer(
//                                                       dealer.dealerCard.length);
//                                                 }
//                                                 //checks if player double A
//                                                 else if (player.playerCard[0] ==
//                                                         'A' &&
//                                                     player.playerCard[1] ==
//                                                         'A') {
//                                                   player.updateHealth(
//                                                       constantsVal.highValue);
//                                                   dealer.updateDealerHealth(
//                                                       constantsVal.highValueN);
//                                                   thingsToDo(
//                                                       constantsVal
//                                                           .doubleAPlayer,
//                                                       player,
//                                                       dealer);
//                                                   numOfCardsDealer(
//                                                       dealer.dealerCard.length);
//                                                 }
//                                                 //checks if dealer double A
//                                                 else if (dealer.dealerCard[0] ==
//                                                         'A' &&
//                                                     dealer.dealerCard[1] ==
//                                                         'A') {
//                                                   player.updateHealth(
//                                                       constantsVal.highValueN);
//                                                   dealer.updateDealerHealth(
//                                                       constantsVal.highValue);
//                                                   thingsToDo(
//                                                       constantsVal
//                                                           .doubleADealer,
//                                                       player,
//                                                       dealer);
//                                                   numOfCardsDealer(
//                                                       dealer.dealerCard.length);
//                                                 }
//                                                 //checks if both are blackjack for draw
//                                                 else if (player.playerCard
//                                                                 .length ==
//                                                             2 &&
//                                                         player.playerNum ==
//                                                             11 &&
//                                                         player.playerCard[0] ==
//                                                             'A' &&
//                                                         dealer.dealerCard.length ==
//                                                             2 &&
//                                                         dealer.dealerNum ==
//                                                             11 &&
//                                                         dealer.dealerCard[0] ==
//                                                             'A' ||
//                                                     player.playerCard.length == 2 &&
//                                                         player.playerNum ==
//                                                             11 &&
//                                                         player.playerCard[0] ==
//                                                             'A' &&
//                                                         dealer.dealerCard.length ==
//                                                             2 &&
//                                                         dealer.dealerNum ==
//                                                             11 &&
//                                                         dealer.dealerCard[1] ==
//                                                             'A' ||
//                                                     player.playerCard.length == 2 &&
//                                                         player.playerNum ==
//                                                             11 &&
//                                                         player.playerCard[1] ==
//                                                             'A' &&
//                                                         dealer.dealerCard.length ==
//                                                             2 &&
//                                                         dealer.dealerNum ==
//                                                             11 &&
//                                                         dealer.dealerCard[0] ==
//                                                             'A' ||
//                                                     player.playerCard.length ==
//                                                             2 &&
//                                                         player.playerNum ==
//                                                             11 &&
//                                                         player.playerCard[1] ==
//                                                             'A' &&
//                                                         dealer.dealerCard
//                                                                 .length ==
//                                                             2 &&
//                                                         dealer.dealerNum ==
//                                                             11 &&
//                                                         dealer.dealerCard[1] ==
//                                                             'A') {
//                                                   player.updatePlayerNum(
//                                                       constantsVal.smolValue);
//                                                   thingsToDo(
//                                                       constantsVal
//                                                           .blackJackDraw,
//                                                       player,
//                                                       dealer);
//                                                   numOfCardsDealer(
//                                                       dealer.dealerCard.length);
//                                                 }
//                                                 //checks if both are double for draw
//                                                 else if (player.playerCard[0] ==
//                                                         player.playerCard[1] &&
//                                                     dealer.dealerCard[0] ==
//                                                         dealer.dealerCard[1]) {
//                                                   thingsToDo(
//                                                       constantsVal.doubleDraw,
//                                                       player,
//                                                       dealer);
//                                                   numOfCardsDealer(
//                                                       dealer.dealerCard.length);
//                                                 }
//                                                 //checks if player blackjack
//                                                 else if (player.playerCard
//                                                                 .length ==
//                                                             2 &&
//                                                         player.playerNum ==
//                                                             11 &&
//                                                         player.playerCard[0] ==
//                                                             'A' ||
//                                                     player.playerCard.length ==
//                                                             2 &&
//                                                         player.playerNum ==
//                                                             11 &&
//                                                         player.playerCard[1] ==
//                                                             'A') {
//                                                   player.updatePlayerNum(
//                                                       constantsVal.smolValue);
//                                                   player.updateHealth(
//                                                       constantsVal.medValue);
//                                                   dealer.updateDealerHealth(
//                                                       constantsVal.medValueN);
//                                                   thingsToDo(
//                                                       constantsVal
//                                                           .blackJackPlayer,
//                                                       player,
//                                                       dealer);
//                                                   numOfCardsDealer(
//                                                       dealer.dealerCard.length);
//                                                 }
//                                                 //checks if dealer blackjack
//                                                 else if (dealer.dealerCard
//                                                             .length ==
//                                                         2 &&
//                                                     dealer.dealerNum == 21) {
//                                                   player.updateHealth(
//                                                       constantsVal.medValueN);
//                                                   dealer.updateDealerHealth(
//                                                       constantsVal.medValue);
//                                                   thingsToDo(
//                                                       constantsVal
//                                                           .blackJackDealer,
//                                                       player,
//                                                       dealer);
//                                                   numOfCardsDealer(
//                                                       dealer.dealerCard.length);
//                                                 } //checks if player double
//                                                 else if (player.playerCard
//                                                             .length ==
//                                                         2 &&
//                                                     player.playerCard[0] ==
//                                                         player.playerCard[1]) {
//                                                   player.updateHealth(
//                                                       constantsVal.medValue);
//                                                   dealer.updateDealerHealth(
//                                                       constantsVal.medValueN);
//                                                   thingsToDo(
//                                                       constantsVal.doublePlayer,
//                                                       player,
//                                                       dealer);
//                                                   numOfCardsDealer(
//                                                       dealer.dealerCard.length);
//                                                 }
//                                                 //checks if dealer double
//                                                 else if (dealer.dealerCard
//                                                             .length ==
//                                                         2 &&
//                                                     dealer.dealerCard[0] ==
//                                                         dealer.dealerCard[1]) {
//                                                   player.updateHealth(
//                                                       constantsVal.medValueN);
//                                                   dealer.updateDealerHealth(
//                                                       constantsVal.medValue);
//                                                   thingsToDo(
//                                                       constantsVal.doubleDealer,
//                                                       player,
//                                                       dealer);
//                                                   numOfCardsDealer(
//                                                       dealer.dealerCard.length);
//                                                 }
//                                               }
//                                               break;
//                                           }
//                                         }
//                                         //show the num of cards as per the current card length
//                                         numOfCards(player.playerCard.length);

//                                         //checks if player or dealer has no more health left
//                                         endDecision(player, context, dealer);
//                                       }
//                                       firstButtonClick = true;
//                                     },
//                             ),
//                             const SizedBox(width: 15.0),
//                             //hit button
//                             SmallButton(
//                                 text: 'Hit',
//                                 onPressed: firstButtonClick
//                                     ? shouldDisableButton
//                                         ? null
//                                         : () {
//                                             //as long as the card is not 5 and the val is less than 21, you can reroll
//                                             if (player.playerCard.length <= 4 &&
//                                                 player.playerNum <
//                                                     card.maxVal &&
//                                                 player.playerNum !=
//                                                     card.maxVal) {
//                                               setState(() => rngNum =
//                                                   Random().nextInt(rngMax));

//                                               //if the card is already taken it rerolls
//                                               while (usedNum.contains(rngNum)) {
//                                                 setState(() => rngNum =
//                                                     Random().nextInt(rngMax));
//                                               }

//                                               //if the card is not a duplicate, it keeps the card
//                                               if (usedNum.contains(rngNum) ==
//                                                   false) {
//                                                 card.takeCards(rngNum);

//                                                 //ensures card val 'A' is 11
//                                                 if (rngNum == 0 ||
//                                                     rngNum == 1 ||
//                                                     rngNum == 2 ||
//                                                     rngNum == 3) {
//                                                   card.cardVal = 1;
//                                                   player.updatePlayerNum(
//                                                       card.cardVal);
//                                                 } else {
//                                                   player.updatePlayerNum(
//                                                       card.cardVal);
//                                                 }
//                                                 player.updatePlayerCard(
//                                                     card.cardNum);
//                                                 usedNum.add(rngNum);

//                                                 //checks if player 5 cards burst
//                                                 if (player.playerCard.length ==
//                                                         5 &&
//                                                     player.playerNum >
//                                                         card.maxVal) {
//                                                   player.updateHealth(
//                                                       constantsVal.highValueN);
//                                                   dealer.updateDealerHealth(
//                                                       constantsVal.highValue);
//                                                   thingsToDo(
//                                                       constantsVal
//                                                           .playerFiveBurst,
//                                                       player,
//                                                       dealer);
//                                                 }
//                                                 //checks if player won by blackjack and 5 cards
//                                                 else if (player.playerCard
//                                                             .length ==
//                                                         5 &&
//                                                     player.playerNum == 21) {
//                                                   player.updateHealth(
//                                                       constantsVal.highestVal);
//                                                   dealer.updateDealerHealth(
//                                                       constantsVal.highestValN);
//                                                   thingsToDo(
//                                                       constantsVal
//                                                           .fiveBlackJackPlayer,
//                                                       player,
//                                                       dealer);
//                                                 }
//                                                 //checks if player won by 5 cards
//                                                 else if (player.playerCard
//                                                             .length ==
//                                                         5 &&
//                                                     player.playerNum <
//                                                         card.maxVal) {
//                                                   player.updateHealth(
//                                                       constantsVal.highValue);
//                                                   dealer.updateDealerHealth(
//                                                       constantsVal.highValueN);
//                                                   thingsToDo(
//                                                       constantsVal.fivePlayer,
//                                                       player,
//                                                       dealer);
//                                                 }
//                                                 //checks if player burst
//                                                 else if (player.playerNum >
//                                                     card.maxVal) {
//                                                   shouldDisableButton = true;
//                                                   print('lost');
//                                                 }
//                                                 //checks if player reach blackjack
//                                                 else if (player.playerNum ==
//                                                     card.maxVal) {
//                                                   shouldDisableButton = true;
//                                                 }

//                                                 // updates player card depending on the card length
//                                                 updatePlayerCards(
//                                                     player, numCard, dealer);
//                                                 updateDealerCards(
//                                                     dealer, numCard);
//                                               }

//                                               //show the num of cards as per the current card length
//                                               numOfCards(
//                                                   player.playerCard.length);

//                                               //checks if player or dealer has no more health left
//                                               endDecision(
//                                                   player, context, dealer);
//                                             } else {
//                                               shouldDisableButton = true;
//                                             }
//                                           }
//                                     : null),
//                             const SizedBox(width: 15.0),
//                             //player hold
//                             SmallButton(
//                               text: 'Stand',
//                               onPressed: firstButtonClick
//                                   ? hasWon
//                                       ? null
//                                       : () {
//                                           setState(
//                                               () => shouldDisableButton = true);

//                                           //dealer's actions
//                                           //smaller value stuff
//                                           while (dealer.dealerNum <
//                                                   card.minVal &&
//                                               dealer.dealerCard.length <= 4) {
//                                             setState(() => rngNum =
//                                                 Random().nextInt(rngMax));

//                                             //if the card is already taken it rerolls
//                                             while (usedNum.contains(rngNum)) {
//                                               setState(() => rngNum =
//                                                   Random().nextInt(rngMax));
//                                             }

//                                             //if the card is not a duplicate, it keeps the card
//                                             if (usedNum.contains(rngNum) ==
//                                                 false) {
//                                               //dealer takes card
//                                               card.takeCards(rngNum);
//                                               //ensures card val 'A' is 11
//                                               if (rngNum == 0 ||
//                                                   rngNum == 1 ||
//                                                   rngNum == 2 ||
//                                                   rngNum == 3) {
//                                                 if (dealer.dealerNum < 12) {
//                                                   card.cardVal = 10;
//                                                   dealer.updateDealerNum(
//                                                       card.cardVal);
//                                                   dealer.updateDealerCard(
//                                                       card.cardNum);
//                                                   usedNum.add(rngNum);
//                                                 } else {
//                                                   card.cardVal = 1;
//                                                   dealer.updateDealerNum(
//                                                       card.cardVal);
//                                                   dealer.updateDealerCard(
//                                                       card.cardNum);
//                                                   usedNum.add(rngNum);
//                                                 }
//                                               } else {
//                                                 dealer.updateDealerNum(
//                                                     card.cardVal);
//                                                 dealer.updateDealerCard(
//                                                     card.cardNum);
//                                                 usedNum.add(rngNum);
//                                               }

//                                               //updates dealer cards as per the card length
//                                               updateDealerCards(
//                                                   dealer, numCard);
//                                             }
//                                           }
//                                           //higher value stuff
//                                           if (dealer.dealerNum >= card.minVal &&
//                                               dealer.dealerNum <
//                                                   card.dealerVal &&
//                                               dealer.dealerCard.length <= 4) {
//                                             setState(() => rngDealer =
//                                                 Random().nextInt(2));
//                                             switch (rngDealer) {
//                                               case 0:
//                                                 setState(() => rngNum =
//                                                     Random().nextInt(rngMax));

//                                                 while (
//                                                     usedNum.contains(rngNum)) {
//                                                   setState(() => rngNum =
//                                                       Random().nextInt(rngMax));
//                                                 }

//                                                 if (usedNum.contains(rngNum) ==
//                                                     false) {
//                                                   //dealer takes card
//                                                   card.takeCards(rngNum);
//                                                   //modifying card A value
//                                                   if (rngNum == 0 ||
//                                                       rngNum == 1 ||
//                                                       rngNum == 2 ||
//                                                       rngNum == 3) {
//                                                     if (dealer.dealerNum < 12) {
//                                                       card.cardVal = 10;
//                                                       dealer.updateDealerNum(
//                                                           card.cardVal);
//                                                       dealer.updateDealerCard(
//                                                           card.cardNum);
//                                                     } else {
//                                                       card.cardVal = 1;
//                                                       dealer.updateDealerNum(
//                                                           card.cardVal);
//                                                       dealer.updateDealerCard(
//                                                           card.cardNum);
//                                                     }
//                                                   } else {
//                                                     dealer.updateDealerNum(
//                                                         card.cardVal);
//                                                     dealer.updateDealerCard(
//                                                         card.cardNum);
//                                                     usedNum.add(rngNum);
//                                                   }

//                                                   //updates dealer cards as per the card length
//                                                   updateDealerCards(
//                                                       dealer, numCard);
//                                                 }
//                                                 break;
//                                               case 1:
//                                                 null;
//                                                 break;
//                                             }
//                                           }

//                                           //if player has less than 16 and holds
//                                           if (player.playerNum < card.minVal) {
//                                             player.updateHealth(
//                                                 constantsVal.medValueN);
//                                             dealer.updateDealerHealth(
//                                                 constantsVal.medValue);
//                                             thingsToDo(
//                                                 constantsVal.lessThanHold,
//                                                 player,
//                                                 dealer);
//                                             numOfCardsDealer(
//                                                 dealer.dealerCard.length);
//                                           }
//                                           //check if dealer 5 cards burst
//                                           else if (dealer.dealerCard.length ==
//                                                   5 &&
//                                               dealer.dealerNum > card.maxVal) {
//                                             player.updateHealth(
//                                                 constantsVal.highValue);
//                                             dealer.updateDealerHealth(
//                                                 constantsVal.highValueN);
//                                             thingsToDo(
//                                                 constantsVal.dealerFiveBurst,
//                                                 player,
//                                                 dealer);
//                                             numOfCardsDealer(
//                                                 dealer.dealerCard.length);
//                                           }
//                                           //checks if both burst
//                                           else if (player.playerNum >
//                                                   card.maxVal &&
//                                               dealer.dealerNum > card.maxVal) {
//                                             thingsToDo(constantsVal.burstDraw,
//                                                 player, dealer);
//                                             numOfCardsDealer(
//                                                 dealer.dealerCard.length);
//                                           }
//                                           //checks if dealer won by blackjack and 5 cards
//                                           else if (dealer.dealerCard.length ==
//                                                   5 &&
//                                               dealer.dealerNum == 21) {
//                                             player.updateHealth(
//                                                 constantsVal.highestValN);
//                                             dealer.updateDealerHealth(
//                                                 constantsVal.highestVal);
//                                             thingsToDo(
//                                                 constantsVal
//                                                     .fiveBlackJackDealer,
//                                                 player,
//                                                 dealer);
//                                             numOfCardsDealer(
//                                                 dealer.dealerCard.length);
//                                           }
//                                           //checks if dealer won by 5 cards
//                                           else if (dealer.dealerCard.length ==
//                                                   5 &&
//                                               dealer.dealerNum > card.minVal &&
//                                               dealer.dealerNum < card.maxVal) {
//                                             player.updateHealth(
//                                                 constantsVal.highValueN);
//                                             dealer.updateDealerHealth(
//                                                 constantsVal.highValueN);
//                                             thingsToDo(constantsVal.fiveDealer,
//                                                 player, dealer);
//                                             numOfCardsDealer(
//                                                 dealer.dealerCard.length);
//                                           }
//                                           //checks if both are same number for draw
//                                           else if (player.playerNum ==
//                                               dealer.dealerNum) {
//                                             thingsToDo(constantsVal.bothDraw,
//                                                 player, dealer);
//                                             numOfCardsDealer(
//                                                 dealer.dealerCard.length);
//                                           }
//                                           //checks if player won by blackjack
//                                           else if (player.playerNum == 21) {
//                                             player.updateHealth(
//                                                 constantsVal.medValue);
//                                             dealer.updateDealerHealth(
//                                                 constantsVal.medValueN);
//                                             thingsToDo(
//                                                 constantsVal.blackJackPlayer,
//                                                 player,
//                                                 dealer);
//                                             numOfCardsDealer(
//                                                 dealer.dealerCard.length);
//                                           }
//                                           //checks if dealer blackjack
//                                           else if (dealer.dealerNum == 21) {
//                                             player.updateHealth(
//                                                 constantsVal.medValueN);
//                                             dealer.updateDealerHealth(
//                                                 constantsVal.medValue);
//                                             thingsToDo(
//                                                 constantsVal.blackJackDealer,
//                                                 player,
//                                                 dealer);
//                                             numOfCardsDealer(
//                                                 dealer.dealerCard.length);
//                                           }
//                                           //player having higher score than dealer after everything
//                                           else if (player.playerNum >
//                                                   dealer.dealerNum &&
//                                               player.playerNum < card.maxVal) {
//                                             coinBank.winCoins();
//                                             player.updateHealth(
//                                                 constantsVal.smolValue);
//                                             dealer.updateDealerHealth(
//                                                 constantsVal.smolValueN);
//                                             thingsToDo(
//                                                 constantsVal.playerHigher,
//                                                 player,
//                                                 dealer);
//                                             numOfCardsDealer(
//                                                 dealer.dealerCard.length);
//                                           } //dealer having higher score after everything
//                                           else if (player.playerNum <
//                                                   dealer.dealerNum &&
//                                               dealer.dealerNum < card.maxVal) {
//                                             player.updateHealth(
//                                                 constantsVal.smolValueN);
//                                             dealer.updateDealerHealth(
//                                                 constantsVal.smolValue);
//                                             thingsToDo(
//                                                 constantsVal.dealerHigher,
//                                                 player,
//                                                 dealer);
//                                             numOfCardsDealer(
//                                                 dealer.dealerCard.length);
//                                           } //dealer burst
//                                           else if (dealer.dealerNum >
//                                               card.maxVal) {
//                                             player.updateHealth(
//                                                 constantsVal.smolValue);
//                                             dealer.updateDealerHealth(
//                                                 constantsVal.smolValueN);
//                                             thingsToDo(constantsVal.dealerBurst,
//                                                 player, dealer);
//                                             numOfCardsDealer(
//                                                 dealer.dealerCard.length);
//                                           } //player burst
//                                           else if (player.playerNum >
//                                               card.maxVal) {
//                                             player.updateHealth(
//                                                 constantsVal.smolValueN);
//                                             dealer.updateDealerHealth(
//                                                 constantsVal.smolValue);
//                                             thingsToDo(constantsVal.playerBurst,
//                                                 player, dealer);
//                                             numOfCardsDealer(
//                                                 dealer.dealerCard.length);
//                                           }
//                                           //checks if player or dealer has no more health left
//                                           endDecision(player, context, dealer);
//                                         }
//                                   : null,
//                             ),
//                           ],
//                         );
//                       }),
//                       //player's health bar
//                     ],
//                   ),
//                   //endingText box
//                   Center(
//                     child: Visibility(
//                       visible: hasWon,
//                       child: RoundEndText(
//                           endingText: endingText, counter: counter),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
